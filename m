Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E807D5A6CD4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 21:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiH3TKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 15:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbiH3TKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 15:10:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1BF26ADF;
        Tue, 30 Aug 2022 12:10:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EDB46B81D89;
        Tue, 30 Aug 2022 19:10:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 515CDC433D7;
        Tue, 30 Aug 2022 19:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661886632;
        bh=urslqRy/AvoWCI3GvC37KP310zxqN8kIiEdiNVgEh/A=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LC6WDT70dd9JfUXK4rP92n1CyP+jTleyWBwR1ZRBSPbl8nnrpj+wU8lJ+LGGTwovJ
         4dxFucf30VYdqiW+/SQCMkvzfHxwSMlvy7thYQ2IEF/OA/MAa+a0O+vMT/DiKD+sE4
         EjPS/95Yg0GHmdntSa7FRbVwr/Iqk/PNO9SvqXvdEx7q7+mMuNrn09taRttI0CHjja
         Fjnjolh5nZuXOftYZofUmh+JwLRodWIB2FnmWRm4nUIAIpz4JfV2rCnjkHZVHJLGdx
         utFQfLGGzAqQgRyosA6jZ2zT06TL+SG6YpIi+/X3Y6T6Wx5rsc80iGQI6yDC+sdJNx
         tke8QS27/U+eg==
Message-ID: <2d98bd73-023d-a43b-0cb6-349e2740e0ff@kernel.org>
Date:   Tue, 30 Aug 2022 22:10:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH linux-next] media: venus: hfi: Remove the unneeded result
 variable
Content-Language: en-US
To:     cgel.zte@gmail.com, mchehab@kernel.org
Cc:     stanimir.varbanov@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, konrad.dybcio@somainline.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220830083753.276861-1-ye.xingchen@zte.com.cn>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220830083753.276861-1-ye.xingchen@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/2022 11:37, cgel.zte@gmail.com wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Return the value venus_hfi_create() directly instead of storing it in
> another redundant variable.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>

Reported-by is used for crediting bug reporters. There is no bug here.
Stop abusing the kernel tags.

Best regards,
Krzysztof
