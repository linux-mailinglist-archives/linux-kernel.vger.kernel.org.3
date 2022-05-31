Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325B153982F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 22:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347851AbiEaUnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 16:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237511AbiEaUnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 16:43:21 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238DA6F4B6;
        Tue, 31 May 2022 13:43:20 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id y8so15362505iof.10;
        Tue, 31 May 2022 13:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=TI/uINot2gV0lsjsvp3p4xP/LTEZ58Gik5+AdIHYdjg=;
        b=WjUDqvXL2OO2piHgXTpKnWg7kXo9tMrfgtr27wgnYh5T8GyiOc6uw6wKAyJO394Zql
         fh+tPnrmnm+ECm22gO3dHdskQ1xsBGOXDIPcZlMK28PdlJ5llhwCCHdC6n+n60CQaTVW
         iw96wJJ4F85cmoal2mWrAfo0V6q8OksPYWhXPMZYzdq/EIu4xG54DN4qDRTeiYT4j4K3
         Lt8pC/MAKLTQ8RKQAG2tBmU6yObfyVkXMBCkWffZ2O6Zp6HD1JSjhfIcwdVvRMI+ijS3
         mSyz4iwbpDpK6M5kQ9YpoF9irzRtLVTpUpukpuDglcjijqmhUvcHgfLPTUmcnlaKJBBw
         GHBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TI/uINot2gV0lsjsvp3p4xP/LTEZ58Gik5+AdIHYdjg=;
        b=Jqj/TuePmGqAjrETXJFb1p50NdGSp8v/2QW29jKfgNjibglVHMgVIbyKjLNeutAHPN
         DX8tjXAsLQrzl9TLvTHudRPVo8gmaFHIhlbcDHbQZe5rfZHl93OvV3fHQj2nJ3iOcmXY
         ptSPasACXQZE2AJYXJ7K0yzqzEk58I69TlIc8Q7OfC1hLW+RRA1HSvDk1TYURLRAnqiW
         cJpHRVyCPffg3XXhqsdw1m4avCJKqf7oXI8bj80woaeqShIYqBS4tuf0m6PCJDwTrfk+
         FPs9JOP6lVGMotb89seEof2SykFMlm2BmuICvCDd22sXGo2bnj1qqmqYOaPahpVRj24I
         tOdw==
X-Gm-Message-State: AOAM530DKkEUsiasQCtK8Xh+dkEi6qBP+qXql/n5VEn3G20wHp3ZHo3h
        JyY1wTtjbaJoSQVDx8LvMpA=
X-Google-Smtp-Source: ABdhPJx8SX0NE5W2CPxvdPdhXAbiWnUhFsofQHgdXznAXgWnYRcojbA8I3LXi1OxTQffPNYS3M4g7A==
X-Received: by 2002:a05:6602:3299:b0:668:6cd3:60e6 with SMTP id d25-20020a056602329900b006686cd360e6mr7510796ioz.183.1654029799400;
        Tue, 31 May 2022 13:43:19 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:bd78:a862:1b9c:aef9? ([2600:1700:2442:6db0:bd78:a862:1b9c:aef9])
        by smtp.gmail.com with ESMTPSA id q11-20020a92050b000000b002d3bb071d5bsm1010934ile.0.2022.05.31.13.43.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 May 2022 13:43:19 -0700 (PDT)
Message-ID: <8d4b8cc3-8433-24f9-1fc5-12d71e640952@gmail.com>
Date:   Tue, 31 May 2022 16:43:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] scripts: dtc: fix a false alarm for
 node_name_chars_strict
Content-Language: en-US
To:     Qun-Wei Lin <qun-wei.lin@mediatek.com>, robh+dt@kernel.org,
        matthias.bgg@gmail.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, casper.li@mediatek.com,
        chinwen.chang@mediatek.com, kuan-ying.lee@mediatek.com
References: <20220531053358.19003-1-qun-wei.lin@mediatek.com>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <20220531053358.19003-1-qun-wei.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/22 01:33, Qun-Wei Lin wrote:
> The function check_node_name_chars_strict issues a false alarm when
> compiling an overlay dts.
> 
> /fragment@0/__overlay__: Character '_' not recommended in node name
> 
> This workaround will fix it by skip checking for node named __overlay__.

This is not a false alarm.

Do not special case node name "__overlay__".  This node name should never
occur in a modern overlay source file.

For details, see "Overlay Source Format" in the "Overlays" section of:
https://elinux.org/Device_Tree_Reference#Overlays

That paragraph also has a pointer to the correct format for overlay
source files, which is slides 29-34 of:
https://elinux.org/Device_Tree_Reference#Overlays

-Frank

> 
> Signed-off-by: Qun-Wei Lin <qun-wei.lin@mediatek.com>
> ---
>  scripts/dtc/checks.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/scripts/dtc/checks.c b/scripts/dtc/checks.c
> index 781ba1129a8e..6ef4f2cd67b9 100644
> --- a/scripts/dtc/checks.c
> +++ b/scripts/dtc/checks.c
> @@ -325,6 +325,11 @@ static void check_node_name_chars_strict(struct check *c, struct dt_info *dti,
>  {
>  	int n = strspn(node->name, c->data);
>  
> +	if (streq(node->name, "__overlay__")) {
> +		/* HACK: Overlay fragments are a special case */
> +		return;
> +	}
> +
>  	if (n < node->basenamelen)
>  		FAIL(c, dti, node, "Character '%c' not recommended in node name",
>  		     node->name[n]);

