Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0975A48F20E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 22:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiANViv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 14 Jan 2022 16:38:51 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:55258 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiANVit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 16:38:49 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id E7FE4614E2CD;
        Fri, 14 Jan 2022 22:38:47 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id RsMcGCKVOPog; Fri, 14 Jan 2022 22:38:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 6E2CE62DA5EE;
        Fri, 14 Jan 2022 22:38:47 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7eW97YoUHxbi; Fri, 14 Jan 2022 22:38:47 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 4B65A62DA5E9;
        Fri, 14 Jan 2022 22:38:47 +0100 (CET)
Date:   Fri, 14 Jan 2022 22:38:47 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        schaecsn <schaecsn@gmx.net>,
        linux-mtd <linux-mtd@lists.infradead.org>
Message-ID: <1440776687.261341.1642196327200.JavaMail.zimbra@nod.at>
In-Reply-To: <20220114104820.1340879-1-gregkh@linuxfoundation.org>
References: <20220114104820.1340879-1-gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] ubifs: use default_groups in kobj_type
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF96 (Linux)/8.8.12_GA_3809)
Thread-Topic: ubifs: use default_groups in kobj_type
Thread-Index: YMthyaOLYqk+kHfGt8tLY1CCh4fFCA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
> An: "linux-kernel" <linux-kernel@vger.kernel.org>
> CC: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "richard" <richard@nod.at>, "schaecsn" <schaecsn@gmx.net>,
> "linux-mtd" <linux-mtd@lists.infradead.org>
> Gesendet: Freitag, 14. Januar 2022 11:48:20
> Betreff: [PATCH v2] ubifs: use default_groups in kobj_type

> There are currently 2 ways to create a set of sysfs files for a
> kobj_type, through the default_attrs field, and the default_groups
> field.  Move the ubifs sysfs code to use default_groups field which has
> been the preferred way since aa30f47cf666 ("kobject: Add support for
> default attribute groups to kobj_type") so that we can soon get rid of
> the obsolete default_attrs field.
> 
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Stefan Schaeckeler <schaecsn@gmx.net>
> Cc: linux-mtd@lists.infradead.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> v2: fix up the changelog text to properly refer to the ubifs code
>    instead of some other subsystem as pointed out by Michael Walle

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard
