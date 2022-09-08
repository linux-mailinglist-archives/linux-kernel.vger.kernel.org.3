Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE3F5B1DD1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbiIHNC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiIHNC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:02:26 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052BC219D;
        Thu,  8 Sep 2022 06:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1662642142;
        bh=AOoOPKC77+UWJGpF5zRGkRjkMKuwwydxKNUx5FZg2zw=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=H5qNtiqED29MMki4Myr9AwBNbSYP4wzxY9Gr/bWbxjz6SOm2K6ihTFcXveZAU1zz5
         efNM/NVR7XZZZzNJMBoJQuwVDVM1hwZt0J/v76Z2onqZJm69RJQorSAU61LNDuVIcI
         Lhy11uNKbNL2JVyV2qlzB/GRu3H9mBux6nmJWNDs=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id E04BC1287A64;
        Thu,  8 Sep 2022 09:02:22 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 56uR_YTdAoND; Thu,  8 Sep 2022 09:02:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1662642142;
        bh=AOoOPKC77+UWJGpF5zRGkRjkMKuwwydxKNUx5FZg2zw=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=H5qNtiqED29MMki4Myr9AwBNbSYP4wzxY9Gr/bWbxjz6SOm2K6ihTFcXveZAU1zz5
         efNM/NVR7XZZZzNJMBoJQuwVDVM1hwZt0J/v76Z2onqZJm69RJQorSAU61LNDuVIcI
         Lhy11uNKbNL2JVyV2qlzB/GRu3H9mBux6nmJWNDs=
Received: from [IPv6:2601:5c4:4300:c551:a71:90ff:fec2:f05b] (unknown [IPv6:2601:5c4:4300:c551:a71:90ff:fec2:f05b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 306831287A5B;
        Thu,  8 Sep 2022 09:02:22 -0400 (EDT)
Message-ID: <3a73cf7f02915891c77dc5a3203dc187f6d91194.camel@HansenPartnership.com>
Subject: Re: [PATCH] drivers/ata: fix repeated words in comments
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Conor.Dooley@microchip.com, wangjianli@cdjrlc.com,
        damien.lemoal@opensource.wdc.com
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 08 Sep 2022 09:02:20 -0400
In-Reply-To: <e2f882f7-6871-a754-fbbd-6a5201f45f4a@microchip.com>
References: <20220908124937.25962-1-wangjianli@cdjrlc.com>
         <e2f882f7-6871-a754-fbbd-6a5201f45f4a@microchip.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-09-08 at 12:56 +0000, Conor.Dooley@microchip.com wrote:
> On 08/09/2022 13:49, wangjianli wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > know the content is safe
> > 
> > Delete the redundant word 'in'.
> > 
> > Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
> > ---
> >   drivers/ata/libata-eh.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> > index 7c128c89b454..ca865a95cf24 100644
> > --- a/drivers/ata/libata-eh.c
> > +++ b/drivers/ata/libata-eh.c
> > @@ -863,7 +863,7 @@ void ata_eh_fastdrain_timerfn(struct timer_list
> > *t)
> >    *
> >    *     Set ATA_PFLAG_EH_PENDING and activate fast drain if
> > @fastdrain
> >    *     is non-zero and EH wasn't pending before.  Fast drain
> > ensures
> > - *     that EH kicks in in timely manner.
> > + *     that EH kicks in timely manner.
> 
> Hey wangjianli,
> This does not look like the right fix to me.. To me, it looks like it
> should be s/in in/in in a/.
> 
> If you're using an automated tool, which I can only assume you are,
> to find these typos it'd be a good idea to check the output for
> correctness prior to sending patches.

And it would also have been nice to accommodate the exact same feedback
last time these patches were posted:

https://lore.kernel.org/all/cec12e246d7151f6041bf553629a3047e81d4afe.camel@HansenPartnership.com/

It's really disappointing you haven't accommodated any feedback either
into your bot or the patches it sends.  Not doing so really does render
this work largely useless.

James


