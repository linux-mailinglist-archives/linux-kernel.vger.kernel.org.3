Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11604FE826
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 20:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358756AbiDLSnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 14:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358778AbiDLSm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 14:42:26 -0400
Received: from relay3.hostedemail.com (relay3.hostedemail.com [64.99.140.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6297D37BEC
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 11:40:07 -0700 (PDT)
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay01.hostedemail.com (Postfix) with ESMTP id 5F461627AC;
        Tue, 12 Apr 2022 18:40:05 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf15.hostedemail.com (Postfix) with ESMTPA id 9C9231B;
        Tue, 12 Apr 2022 18:40:03 +0000 (UTC)
Message-ID: <e3cb339e8123ec84392d3050fbd689fcf2255f4a.camel@perches.com>
Subject: Re: [PATCH 4/5] MAINTAINERS: update MAINTAINERS file
From:   Joe Perches <joe@perches.com>
To:     William Zhang <william.zhang@broadcom.com>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     Samyon Furman <samyon.furman@broadcom.com>,
        Joel Peshkin <joel.peshkin@broadcom.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Dan Beygelman <dan.beygelman@broadcom.com>,
        Tomer Yacoby <tomer.yacoby@broadcom.com>,
        Anand Gore <anand.gore@broadcom.com>,
        Kursad Oney <kursad.oney@broadcom.com>,
        linux-kernel@vger.kernel.org
Date:   Tue, 12 Apr 2022 11:40:02 -0700
In-Reply-To: <51c11778-b252-53b0-8161-9d7928816b55@broadcom.com>
References: <20220411172815.20916-1-william.zhang@broadcom.com>
         <20220411172815.20916-5-william.zhang@broadcom.com>
         <38692bbdd535dfe249babd1eb6aca24b2e1070e8.camel@perches.com>
         <51c11778-b252-53b0-8161-9d7928816b55@broadcom.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Stat-Signature: s7z1t1nasjp56dbkjk4bpihc3c5t4eez
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 9C9231B
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+/noIBosBpBNXNp3kf19d2PYVs+U1ATiM=
X-HE-Tag: 1649788803-793185
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-04-12 at 11:37 -0700, William Zhang wrote:
> Hi Joe,
> 
> On 4/12/22 09:38, Joe Perches wrote:
> > On Mon, 2022-04-11 at 10:28 -0700, William Zhang wrote:
> > > Add maintainters, SCM tree, files and directories for the new BCMBCA
> > 
> > typo of maintainers
> Thanks for catching that.
> 
> > 
> > > arch. Only add 47622 for this change and will update in the future
> > > when more SoCs are supported.
> > []
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > []
> > > @@ -3740,6 +3740,20 @@ F:	drivers/net/dsa/bcm_sf2*
> > >   F:	include/linux/dsa/brcm.h
> > >   F:	include/linux/platform_data/b53.h
> > >   
> > > +BROADCOM BCMBCA ARM ARCHITECTURE
> > > +M:	William Zhang <william.zhang@broadcom.com>
> > > +M:	Anand Gore <anand.gore@broadcom.com>
> > > +M:	Kursad Oney <kursad.oney@broadcom.com>
> > > +M:	bcm-kernel-feedback-list@broadcom.com
> > 
> > Unnamed exploders are not maintainers.
> > 
> > Maybe:
> > 
> > R:	Broadcom BCMBCA reviewers <bcm-kernel-feedback-list@broadcom.com>
> Copied from other BCM entry in this file. It is mailing list which does 
> not really need an name. And I guess it is better to be put under L as 
> other BCM entry does.

I just sent a patch to convert all of these to R:

https://lore.kernel.org/lkml/04eb301f5b3adbefdd78e76657eff0acb3e3d87f.camel@perches.com/T/#u


