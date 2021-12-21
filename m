Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 577F147C871
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 21:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235275AbhLUUzZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 21 Dec 2021 15:55:25 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:43438 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235188AbhLUUzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 15:55:24 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 206BB62DA5EA;
        Tue, 21 Dec 2021 21:55:22 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id vXagFKvHTWqH; Tue, 21 Dec 2021 21:55:20 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id D4C5862DA5F1;
        Tue, 21 Dec 2021 21:55:20 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id PzDNqqkt_Mly; Tue, 21 Dec 2021 21:55:20 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id ACC7462DA5EA;
        Tue, 21 Dec 2021 21:55:20 +0100 (CET)
Date:   Tue, 21 Dec 2021 21:55:20 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Jeff Dike <jdike@addtoit.com>,
        anton ivanov <anton.ivanov@cambridgegreys.com>,
        kernel@axis.com, linux-kernel <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>
Message-ID: <342397676.191011.1640120120622.JavaMail.zimbra@nod.at>
In-Reply-To: <20211208151123.29313-1-vincent.whitchurch@axis.com>
References: <20211208151123.29313-1-vincent.whitchurch@axis.com>
Subject: Re: [PATCH 0/2] Devicetree support for UML
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF95 (Linux)/8.8.12_GA_3809)
Thread-Topic: Devicetree support for UML
Thread-Index: Id4ge0Mfs4XDpGWkd/TYkR1CA9d4zw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vincent,

----- Ursprüngliche Mail -----
> Von: "Vincent Whitchurch" <vincent.whitchurch@axis.com>
> An: "Jeff Dike" <jdike@addtoit.com>, "richard" <richard@nod.at>, "anton ivanov" <anton.ivanov@cambridgegreys.com>
> CC: kernel@axis.com, "linux-kernel" <linux-kernel@vger.kernel.org>, "linux-um" <linux-um@lists.infradead.org>,
> "devicetree" <devicetree@vger.kernel.org>, "Vincent Whitchurch" <vincent.whitchurch@axis.com>
> Gesendet: Mittwoch, 8. Dezember 2021 16:11:21
> Betreff: [PATCH 0/2] Devicetree support for UML

> This series add support for passing a devicetree blob to UML.  It can be used
> for testing device drivers.

Nice feature.
Code looks good so far. But while building I'm facing this warning:

WARNING: unmet direct dependencies detected for OF_EARLY_FLATTREE
  Depends on [n]: OF [=n]
  Selected by [y]:
  - UML [=y]


Please note that my UML config has CONFIG_OF=n.

Thanks,
//richard
