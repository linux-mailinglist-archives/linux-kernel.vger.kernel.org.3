Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0B62483496
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 17:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbiACQJg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 3 Jan 2022 11:09:36 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:40315 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbiACQJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 11:09:34 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 03B8460009;
        Mon,  3 Jan 2022 16:09:29 +0000 (UTC)
Date:   Mon, 3 Jan 2022 17:09:28 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Clark Wang <xiaoning.wang@nxp.com>
Cc:     conor.culhane@silvaco.com, alexandre.belloni@bootlin.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5 4/8] i3c: master: svc: add support for slave to stop
 returning data
Message-ID: <20220103170928.76b2369f@xps13>
In-Reply-To: <20211227074529.1660398-5-xiaoning.wang@nxp.com>
References: <20211227074529.1660398-1-xiaoning.wang@nxp.com>
        <20211227074529.1660398-5-xiaoning.wang@nxp.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Clark,

xiaoning.wang@nxp.com wrote on Mon, 27 Dec 2021 15:45:25 +0800:

> When i3c controller reads data from slave device, slave device can stop
> returning data with an ACK after any byte.
> Add this support for svc i3c controller. Otherwise, it will timeout
> when the slave device ends the read operation early.
> 
> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> Reviewed-by: Jun Li <jun.li@nxp.com>

Looks good to me :)

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Cheers,
Miquèl
