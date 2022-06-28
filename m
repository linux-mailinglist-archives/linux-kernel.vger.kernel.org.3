Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A5755E6D7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346877AbiF1OhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 10:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346842AbiF1OhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 10:37:05 -0400
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15CC2C647;
        Tue, 28 Jun 2022 07:37:03 -0700 (PDT)
Received: by mail-il1-f176.google.com with SMTP id i17so8255579ils.12;
        Tue, 28 Jun 2022 07:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A1IJcZJ/hlL884WwHr614CqNiCZ/WVZ7mtlSDIsFU1s=;
        b=iObil4jRBsYFr5DgetYsegl9YtOUJRdmVQE6lDRHKX9g00Mwgyg1cZzPg4G9/63J38
         xWkb8rYopUcqETdB773LPVH1CPp7vDfZnh8/OVsArCwmXOAY/eps5I9h2EoQR3dElm/p
         uupTlL8gHQe0WYpfQYxBl/nUf0RhSNKnCOS1B4OnQfUl65ZHPLQMt43pNNlaBYzQv1pP
         z+oJnbEMz3i/NPLtcpiAUQJ62SW+KwFYWU8PyiD008V5BvOxBDHDBTBwm9q8hiTgAP+y
         F5TwuTGTfr/UAVWxFDGrwsSMP+dDakTO+56ehzP/FDAlA4ZuIEUN1SytHnCEZvyxyshD
         0qjg==
X-Gm-Message-State: AJIora+2ozQj7iNp4geFz4Xrrrp40w/sjLQqKSpIBdqDrbQCnVQZp8Yw
        SxpL6KPJTaQLVLKaF9R1fw==
X-Google-Smtp-Source: AGRyM1vWantaaEVLWxSMmc91idW90bcTQDTqEJa+Xl/smZ1uzAXfk0cGXzKcb6Tr53u0DPCJ/lazrw==
X-Received: by 2002:a05:6e02:16cf:b0:2d1:a511:499b with SMTP id 15-20020a056e0216cf00b002d1a511499bmr11115588ilx.77.1656427023250;
        Tue, 28 Jun 2022 07:37:03 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id u13-20020a5d818d000000b0067513ad66c3sm5448207ion.41.2022.06.28.07.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 07:37:02 -0700 (PDT)
Received: (nullmailer pid 425510 invoked by uid 1000);
        Tue, 28 Jun 2022 14:36:59 -0000
Date:   Tue, 28 Jun 2022 08:36:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     frowand.list@gmail.com
Cc:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lizhi Hou <lizhi.hou@xilinx.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/2]  of: unittest: treat missing of_root as error
 instead of fixing up
Message-ID: <20220628143659.GA424332-robh@kernel.org>
References: <20220624034327.2542112-1-frowand.list@gmail.com>
 <20220624034327.2542112-3-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624034327.2542112-3-frowand.list@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 10:43:27PM -0500, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
>  setup_of() now ensures that of_root node is populated with the
>  root of a default devicetree. Remove the unittest code that
>  created of_root if it was missing.  Verify that of_root is
>  valid before attempting to attach the testcase-data subtree.

What happened with the formatting here?

> 
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
>  drivers/of/unittest.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
> index 7f6bba18c515..9d106998c1f2 100644
> --- a/drivers/of/unittest.c
> +++ b/drivers/of/unittest.c
> @@ -1469,20 +1469,16 @@ static int __init unittest_data_add(void)
>  		return -EINVAL;
>  	}
>  
> -	if (!of_root) {
> -		of_root = unittest_data_node;
> -		for_each_of_allnodes(np)
> -			__of_attach_node_sysfs(np);
> -		of_aliases = of_find_node_by_path("/aliases");
> -		of_chosen = of_find_node_by_path("/chosen");
> -		of_overlay_mutex_unlock();
> -		return 0;
> -	}
> -
>  	EXPECT_BEGIN(KERN_INFO,
>  		     "Duplicate name in testcase-data, renamed to \"duplicate-name#1\"");
>  
>  	/* attach the sub-tree to live tree */
> +	if (!of_root) {
> +		pr_warn("%s: no live tree to attach sub-tree\n", __func__);
> +		kfree(unittest_data);
> +		return -ENODEV;
> +	}
> +
>  	np = unittest_data_node->child;
>  	while (np) {
>  		struct device_node *next = np->sibling;
> -- 
> Frank Rowand <frank.rowand@sony.com>
> 
> 
