Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7963F5AC106
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 21:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbiICTFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 15:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbiICTFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 15:05:05 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7188524976
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 12:05:00 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 4D181240002;
        Sat,  3 Sep 2022 19:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1662231898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eRSqR1ruQyE4MRuP6dAFwatwvofglcsxkbjIYnnnrR0=;
        b=OK1IfdUf57Lx3w72qdpVP81/ueK8BptN2FDHhaw0uF9YYVdFJfoU25O/uFrE9MNJ2Lg7cj
        Zj0z+5UTZ5HpS2/hquYbusiAp29FYn/BPabE7UL1OO/Lr11uorQ3+bbnsVetwKBISE4NJ6
        5okK3wj83VBY9XnHOrvkVh21E7euP8cFIJKTY5HSnh3JUd3MmoIveX0TVKpSCleFPZ+XWm
        fGg3YlflOUKaVqX/5CwY0kSZl/XG7acIJnTQRGzz1OpcrspuBs4SPLAuRH94y48D3nnYav
        1XWmaroz1l2qd40YaS3zFWp+9GQxzmdITnxHmSyPaOf68CXenZxIeFbbdNTAdw==
Date:   Sat, 3 Sep 2022 21:04:53 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Roger Quadros <rogerq@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Colin Ian King <colin.king@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        William Zhang <william.zhang@broadcom.com>
Subject: Re: [PATCH 0/2] mtd: rawnand: brcmnand: Glue driver Kconfig entries
Message-ID: <20220903210453.0bf8734b@xps-13>
In-Reply-To: <cdde4e0a-dfd7-51d7-0800-7ac124c34ff7@gmail.com>
References: <20220711222323.4048197-1-f.fainelli@gmail.com>
        <6008ef46-ccdb-ea01-f9fb-4f8fceed2d29@gmail.com>
        <cdde4e0a-dfd7-51d7-0800-7ac124c34ff7@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Florian,

f.fainelli@gmail.com wrote on Sat, 3 Sep 2022 11:42:07 -0700:

> On 8/4/2022 10:55 AM, Florian Fainelli wrote:
> > On 7/11/22 15:23, Florian Fainelli wrote: =20
> >> Hi all,
> >>
> >> This patch series allows for a finer control over the BRCMNAND driver
> >> glue driver selection such that it defaults to the various platforms
> >> enabled in the configuration file. =20
> >=20
> > Miquel are you able to review and apply those patches if satisfactory? =
Thanks! =20
>=20
> Ping?

Sorry for the delay, I was off for almost all July/August, I need to
sync with Richard and start catching up. I'll do my best but with
LPC/ELC-E approaching, I'm far from close to have enough spare time! At
the latest, I will settle the situation right after those conferences.=20

Thanks,
Miqu=C3=A8l
