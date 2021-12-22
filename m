Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E55747D7E3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 20:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236321AbhLVTlT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 22 Dec 2021 14:41:19 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:38728 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbhLVTlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 14:41:19 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id A425D62DA5EC;
        Wed, 22 Dec 2021 20:41:17 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id MEvbfByi0Az5; Wed, 22 Dec 2021 20:41:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 432F862DA603;
        Wed, 22 Dec 2021 20:41:17 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id R7xKuktAAKkt; Wed, 22 Dec 2021 20:41:17 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 15D6362DA5EC;
        Wed, 22 Dec 2021 20:41:17 +0100 (CET)
Date:   Wed, 22 Dec 2021 20:41:16 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     anton ivanov <anton.ivanov@cambridgegreys.com>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Dike <jdike@addtoit.com>,
        Rob Herring <robh+dt@kernel.org>, kernel <kernel@axis.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1118129237.194759.1640202076897.JavaMail.zimbra@nod.at>
In-Reply-To: <38342157-f9c5-42dd-db04-3a13756bd70b@cambridgegreys.com>
References: <20211221090447.1567-1-vincent.whitchurch@axis.com> <5f104044649ec60ba93648e68c3df2183e032072.camel@sipsolutions.net> <20211222103417.GB25135@axis.com> <38342157-f9c5-42dd-db04-3a13756bd70b@cambridgegreys.com>
Subject: Re: [PATCH] um: virtio_uml: allow probing from devicetree
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF95 (Linux)/8.8.12_GA_3809)
Thread-Topic: virtio_uml: allow probing from devicetree
Thread-Index: NRZUvbv9I383VZHDI8J/r69RFLNgsg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "anton ivanov" <anton.ivanov@cambridgegreys.com> 
>> Also, DT bindings are supposed to be generic and based on what the
>> hardware has, but here we have no hardware and something very Linux and
>> UML-specific.
> 
> This will probably need to be added to the general UML documentation. I
> will take care of that once the patches are in the tree.

That would be great! Patch applied.

Thanks,
//richard
