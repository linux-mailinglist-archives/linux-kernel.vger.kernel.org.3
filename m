Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80CCA597A05
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 01:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242213AbiHQXMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 19:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbiHQXMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 19:12:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5AFACA0A;
        Wed, 17 Aug 2022 16:12:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 670D061135;
        Wed, 17 Aug 2022 23:12:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A9CC433C1;
        Wed, 17 Aug 2022 23:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660777931;
        bh=ZSSUC+qtjCm/TAcrRhIh+enUapw+ThiKrZKpHspjssE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jNu0FLRyq1xMrL6EdqangxdsJ8+7bApla2HekUUzxfUpnMs2oOij5qSzOK0C1hAvb
         tbBzKpZ4KAgBsRJgczsDViYGNzhiUMs2uJVtTqug5DUXFSu84awb6qXR8sJpHE2fE6
         RLCoIup4erPAH1VvfjHHoBScvMTh3LUfVc5LbxTw26lKe7EAKq3x/0MY2kJZ7p0vXb
         zvSE60yYn6vZmwLhMroyL2bQR07ngOiXh9VjbCHqbkiitVrvCY+5bIevJztIfEwf8q
         w+6bwlHwk8PyMuvUyFzRcs4G/NSHnmSbZQ9PLinZS58O9Ns49gYS3/mzEtplQt04p1
         MZ152tmTr415A==
Received: by pali.im (Postfix)
        id EE03F77A; Thu, 18 Aug 2022 01:12:08 +0200 (CEST)
Date:   Thu, 18 Aug 2022 01:12:08 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Andrew Lunn <andrew@lunn.ch>, Mauri Sandberg <maukka@ext.kapsi.fi>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: arm: marvell: Add Orion codenames and
 archive homepage
Message-ID: <20220817231208.42emdluzead2hweg@pali>
References: <20220719080807.16729-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220719080807.16729-1-pali@kernel.org>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 July 2022 10:08:07 Pali Rohár wrote:
> Orion codenames are extracted from menuconfig ARCH_ORION5X and
> old Orion homepage with 88F5182/88F5281 was found in web archive.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>

PING?

> ---
> In archived homepage are also links to erratas and other Orion documents
> but apparently webarchive does not have backup copy of it :-( and Marvell
> already removed all documentation from their web sites :-(
> ---
>  Documentation/arm/marvell.rst | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/arm/marvell.rst b/Documentation/arm/marvell.rst
> index 2f41caa0096c..8540437f6a79 100644
> --- a/Documentation/arm/marvell.rst
> +++ b/Documentation/arm/marvell.rst
> @@ -14,18 +14,20 @@ Orion family
>  
>    Flavors:
>          - 88F5082
> -        - 88F5181
> -        - 88F5181L
> -        - 88F5182
> +        - 88F5181  a.k.a Orion-1
> +        - 88F5181L a.k.a Orion-VoIP
> +        - 88F5182  a.k.a Orion-NAS
>  
>                 - Datasheet: https://web.archive.org/web/20210124231420/http://csclub.uwaterloo.ca/~board/ts7800/MV88F5182-datasheet.pdf
>                 - Programmer's User Guide: https://web.archive.org/web/20210124231536/http://csclub.uwaterloo.ca/~board/ts7800/MV88F5182-opensource-manual.pdf
>                 - User Manual: https://web.archive.org/web/20210124231631/http://csclub.uwaterloo.ca/~board/ts7800/MV88F5182-usermanual.pdf
>                 - Functional Errata: https://web.archive.org/web/20210704165540/https://www.digriz.org.uk/ts78xx/88F5182_Functional_Errata.pdf
> -        - 88F5281
> +        - 88F5281  a.k.a Orion-2
>  
>                 - Datasheet: https://web.archive.org/web/20131028144728/http://www.ocmodshop.com/images/reviews/networking/qnap_ts409u/marvel_88f5281_data_sheet.pdf
> -        - 88F6183
> +        - 88F6183  a.k.a Orion-1-90
> +  Homepage:
> +        https://web.archive.org/web/20080607215437/http://www.marvell.com/products/media/index.jsp
>    Core:
>  	Feroceon 88fr331 (88f51xx) or 88fr531-vd (88f52xx) ARMv5 compatible
>    Linux kernel mach directory:
> -- 
> 2.20.1
> 
