Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 435454972AF
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 16:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237984AbiAWPnv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 23 Jan 2022 10:43:51 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:57577 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235306AbiAWPnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 10:43:50 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 9E36C100002;
        Sun, 23 Jan 2022 15:43:45 +0000 (UTC)
Date:   Sun, 23 Jan 2022 16:43:44 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     s921975628@gmail.com
Cc:     richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mtd: rawnand: nandsim: Replace overflow check with
 kzalloc to single kcalloc
Message-ID: <20220123164344.015f1447@xps13>
In-Reply-To: <20211225100607.118932-1-s921975628@gmail.com>
References: <20211225100607.118932-1-s921975628@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

s921975628@gmail.com wrote on Sat, 25 Dec 2021 18:06:07 +0800:

> From: RinHizakura <s921975628@gmail.com>
> 
> Instead of self-checking overflow and allocating an array of specific size
> by counting the total required space handy, we already have existed kernel
> API which responses for all these works.
> 
> Signed-off-by: RinHizakura <s921975628@gmail.com>

Series applied to nand/next.

Thanks,
Miquèl
