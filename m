Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194A34E4753
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 21:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233191AbiCVUSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 16:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiCVURv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 16:17:51 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29C6245B5;
        Tue, 22 Mar 2022 13:16:23 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 64D721F42F6C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647980182;
        bh=zvjZFzW+8eVSVcYN3AYKVNtaszJpAGzALDjXSoRAcFk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kabOxj6vgJIgSb4+zJOxfFHg2gUKHisLnUGdjCXL47ayPobEqtmU85Se5OnNj1ZKJ
         lHP5OYBoSg+zSqGB2cC6MdOldJKA/cs+Liva5ByTacI1Awr38/OSbKArkS2YRXwX/7
         qK/jOXG1uryB6BADQMhkNszS+CnEP8PqjbkNXCk9XkidPUA9rxS7USwczoQ1Vxjnkr
         q6l2devdSG6Oi6kfoaZcqxXptUJQEKRp+6QU2roR80ZDC3ughWFSIKZSdgpE6+N5TI
         kwx2ariVWo4dTQHkIaw55uVLOOBXeuVUPYzbRvYmavZCpmxL+ThvshomxHrZaUUVnJ
         9sgQUhcnq+aNA==
Date:   Tue, 22 Mar 2022 16:16:17 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        Hui Liu <hui.liu@mediatek.com>
Subject: Re: [PATCH v4 19/22] arm64: dts: mt8192: Add the mmsys reset bit to
 reset the dsi0
Message-ID: <20220322201617.s55p4xp3hcb4zgvi@notapiano>
References: <20220318144534.17996-1-allen-kh.cheng@mediatek.com>
 <20220318144534.17996-20-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220318144534.17996-20-allen-kh.cheng@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 10:45:31PM +0800, Allen-KH Cheng wrote:
> Reset the DSI hardware is needed to prevent different settings between
> the bootloader and the kernel.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

> ---
>  include/dt-bindings/reset/mt8192-resets.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/dt-bindings/reset/mt8192-resets.h b/include/dt-bindings/reset/mt8192-resets.h
> index be9a7ca245b9..764ca9910fa9 100644
> --- a/include/dt-bindings/reset/mt8192-resets.h
> +++ b/include/dt-bindings/reset/mt8192-resets.h
> @@ -27,4 +27,7 @@
>  
>  #define MT8192_TOPRGU_SW_RST_NUM				23
>  
> +/* MMSYS resets */
> +#define MT8192_MMSYS_SW0_RST_B_DISP_DSI0			15
> +
>  #endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT8192 */
> -- 
> 2.18.0
> 
> 
