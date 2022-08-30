Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B1A5A5D21
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 09:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbiH3HiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 03:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbiH3HiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 03:38:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F294C7F9A;
        Tue, 30 Aug 2022 00:38:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D046D614DA;
        Tue, 30 Aug 2022 07:38:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAAB4C433C1;
        Tue, 30 Aug 2022 07:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661845097;
        bh=a1VeHRSBHSS7rf/yq2/xorcuUbYUfWNTRpIjfM6yn6s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QJyPkXExYyaudVb9dm57jlNwJ0zKgPgZH1qqEsZ26rmO/2cpripu2PwNJynB5YSYr
         +B7KMyPLpRNq4/yt084OgOWDVxCYZ82nGQj7rMbSfycZLMC8ew8sYBj9YmupQ/c2l6
         9MCKE/Mv3dH5Kk3Nu9Fh+HyONkMBn/TtDUSg7dzvazwH+/ZbZhNs6XZSp0XOY2N8fm
         Egn38A0QmhUOxaNhJigLcZlHndouJKUzawQcJulHywgPxrDIRNl9PnTGDE6v6c3UxK
         ToF7yGsea1p4I3xp+0+Lwj5phUq0z9/5VGRNObbgJTDG34958MT9UHrqwWo3gfQ+iR
         j57Z5CmjVwcCw==
Date:   Tue, 30 Aug 2022 13:08:12 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] phy: qcom-qmp: Add SC8280XP USB PHYs
Message-ID: <Yw2+ZOn6pVN37NyO@matsya>
References: <20220810042303.3583194-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220810042303.3583194-1-bjorn.andersson@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-08-22, 21:22, Bjorn Andersson wrote:
> Introduce UNI and combo USB PHYs for the Qualcomm SC8280XP platform.

Applied, thanks

-- 
~Vinod
