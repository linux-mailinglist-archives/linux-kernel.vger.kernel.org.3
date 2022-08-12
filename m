Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A18590E97
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 12:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237313AbiHLKCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 06:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbiHLKC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 06:02:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA48A598F;
        Fri, 12 Aug 2022 03:02:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 13722B823AB;
        Fri, 12 Aug 2022 10:02:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1438C433D6;
        Fri, 12 Aug 2022 10:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660298544;
        bh=ZwKs8KhmRqSPqx+VzPtir7Tp0N1RKVbuJdmAf5L/E+o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Bw9Rznu5rHwmW8F7BbIA74iNm8r5cKMvEVjWsib0mk83dIWuRlqrSVVSpUudB9NMH
         dJzcIVXa9YIS4y1gyx3pz1w8SRfft9P9scX/9VsWd16uyGTsLx6+S/PspenaBfLyBg
         7AfanqBWnR5vk6elo/yskgtln6O8FjtEL1DMeDN6rf50POZ0ATvK/uMsPlD+q+bEKY
         2I5gp6zRTeugYmcFVuByEZUNcrI/labGwWYDtd0hD+o2aFUHOe1SbPx07A/1zx2ANK
         KnwPWOMiMbz3ytt9X96GQsUh/NFEd0/HE3Euob5p2BVAj5j04Dbz0Iq/pyJB+OUud6
         llYxSpUoOmrsQ==
Message-ID: <07c3b971-a1b1-aff3-3d24-9101a174a4ae@kernel.org>
Date:   Fri, 12 Aug 2022 13:02:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 16/26] thermal/drivers/exynos: of_thermal_get_ntrips()
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "open list:SAMSUNG THERMAL DRIVER" 
        <linux-samsung-soc@vger.kernel.org>,
        "moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" 
        <linux-arm-kernel@lists.infradead.org>
References: <20220809220436.711020-1-daniel.lezcano@linaro.org>
 <20220809220436.711020-17-daniel.lezcano@linaro.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220809220436.711020-17-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/2022 01:04, Daniel Lezcano wrote:
> The thermal core framework allows to get the number of thermal trips,
> use it instead of visiting the thermal core structure internals.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
