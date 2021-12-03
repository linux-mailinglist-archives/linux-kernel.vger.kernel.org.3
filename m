Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D47C7467F2F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 22:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353834AbhLCVYZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 3 Dec 2021 16:24:25 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:47427 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235538AbhLCVYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 16:24:24 -0500
Received: from smtpclient.apple (p5b3d2e91.dip0.t-ipconnect.de [91.61.46.145])
        by mail.holtmann.org (Postfix) with ESMTPSA id ABB26CED20;
        Fri,  3 Dec 2021 22:20:58 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [PATCH v2] Bluetooth: btmtksdio: enable msft opcode
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211201201351.2552-1-lukasz.bartosik@semihalf.com>
Date:   Fri, 3 Dec 2021 22:20:58 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        upstream@semihalf.com
Content-Transfer-Encoding: 8BIT
Message-Id: <2852634C-7A15-4B64-A76C-77047F9C5007@holtmann.org>
References: <20211201201351.2552-1-lukasz.bartosik@semihalf.com>
To:     Lukasz Bartosik <lb@semihalf.com>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

> Enable msft opcode for mt7921 chip.
> 
> Signed-off-by: Łukasz Bartosik <lb@semihalf.com>
> ---
> drivers/bluetooth/btmtksdio.c | 2 ++
> 1 file changed, 2 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

