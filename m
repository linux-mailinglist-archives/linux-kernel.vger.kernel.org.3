Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED565A460A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 11:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiH2J0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 05:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiH2J0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 05:26:45 -0400
Received: from smtpout30.security-mail.net (smtpout30.security-mail.net [85.31.212.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FE2491C2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 02:26:42 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by fx306.security-mail.net (Postfix) with ESMTP id 6352F399566
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 11:26:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1661765200;
        bh=ETqnylzhgvqnG9aezGh1//TYB5UoDpnh0z7oWAMoy7k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=O6QU3r0aoz9OInH106mhWSWh08qfCYP04CV3Gck424JemDXvBKef7h7V9aMUPih4K
         Vxy1lkpSHSXZI6MoX61t8vkf2UWiOg3GH2QGtq9M9wjFGgV/ohHLPj1YcuIBi2GqDu
         O9nXkDvuydxBL3SVMwfxbmjfADWvTwfDUgrX2UeI=
Received: from fx306 (localhost [127.0.0.1]) by fx306.security-mail.net
 (Postfix) with ESMTP id 8E98A399568; Mon, 29 Aug 2022 11:26:39 +0200 (CEST)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx306.security-mail.net (Postfix) with ESMTPS id E3376399567; Mon, 29 Aug
 2022 11:26:38 +0200 (CEST)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id C79E627E039C; Mon, 29 Aug 2022
 11:26:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id AF25027E039F; Mon, 29 Aug 2022 11:26:38 +0200 (CEST)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 g8VGtsj8q8xr; Mon, 29 Aug 2022 11:26:38 +0200 (CEST)
Received: from tellis.lin.mbt.kalray.eu (unknown [192.168.36.206]) by
 zimbra2.kalray.eu (Postfix) with ESMTPSA id 9B20627E039C; Mon, 29 Aug 2022
 11:26:38 +0200 (CEST)
X-Virus-Scanned: E-securemail, by Secumail
Secumail-id: <10774.630c864e.e2066.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu AF25027E039F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1661765198;
 bh=mkoOcxAELU1ZXdD765sD5k18u8GfbVW+FPpt8WMKsFg=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=eBUHh/M7Cji8/cCO+yv1whA26VEL1/fwhd7ec8iBBt2p82lUXqp/r2ZuOdOInJGZH
 5cjj9D8JxEBpwPZLjTfQw9pxwkjm0/hj2E511hLyQpuP7szJuFdJJWIEM1vEn67wvk
 FZKTIAB4HBK1IsFSraJPFUuw3NY7S2ulyN06CRFM=
Date:   Mon, 29 Aug 2022 11:26:37 +0200
From:   Jules Maselbas <jmaselbas@kalray.eu>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Conor.Dooley@microchip.com,
        Bagas Sanjaya <bagasdotme@gmail.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4] Remove duplicated words across the whole
 documentation
Message-ID: <20220829092637.GF10294@tellis.lin.mbt.kalray.eu>
References: <20220826163458.1142-1-jmaselbas@kalray.eu>
 <20220826165634.5617-1-jmaselbas@kalray.eu>
 <d785f8aa-5a41-006d-394c-2bba64047cb4@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d785f8aa-5a41-006d-394c-2bba64047cb4@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-ALTERMIMEV2_out: done
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Fri, Aug 26, 2022 at 04:06:14PM -0700, Randy Dunlap wrote:
> Hi Jules,
> 
> On 8/26/22 09:56, Jules Maselbas wrote:
> > diff --git a/Documentation/networking/switchdev.rst b/Documentation/networking/switchdev.rst
> > index f1f4e6a85a29..6a0c2cc722eb 100644
> > --- a/Documentation/networking/switchdev.rst
> > +++ b/Documentation/networking/switchdev.rst
> > @@ -161,7 +161,7 @@ The switchdev driver can know a particular port's position in the topology by
> >  monitoring NETDEV_CHANGEUPPER notifications.  For example, a port moved into a
> >  bond will see it's upper master change.  If that bond is moved into a bridge,
> >  the bond's upper master will change.  And so on.  The driver will track such
> > -movements to know what position a port is in in the overall topology by
> > +movements to know what position a port is in the overall topology by
> 
> I don't think any change is needed here.
> The rest look good to me.
You're right.

> 
> >  registering for netdevice events and acting on NETDEV_CHANGEUPPER.
> 
> 
> > There are likely more duplicated words.
> 
> /methinks that you have barely scratched the surface.  :)
yeah... "am doing my part" ;)

Thanks for your time, will send a v5 shortly




