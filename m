Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48D6F48659C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 14:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239798AbiAFNyo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 6 Jan 2022 08:54:44 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:58057 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239519AbiAFNyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 08:54:44 -0500
Received: from smtpclient.apple (p4fefca45.dip0.t-ipconnect.de [79.239.202.69])
        by mail.holtmann.org (Postfix) with ESMTPSA id B7A2DCECD5;
        Thu,  6 Jan 2022 14:54:42 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH] Bluetooth: hci_qca: Fix NULL vs IS_ERR_OR_NULL check in
 qca_serdev_probe
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211224080250.3123-1-linmq006@gmail.com>
Date:   Thu, 6 Jan 2022 14:54:42 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rocky Liao <rjliao@codeaurora.org>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <0DF6BF49-0CB4-4F07-8F82-6B66C392E25C@holtmann.org>
References: <20211224080250.3123-1-linmq006@gmail.com>
To:     Miaoqian Lin <linmq006@gmail.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miaoqian,

> The function devm_gpiod_get_index() return error pointers on error.
> Thus devm_gpiod_get_index_optional() could return NULL and error pointers.
> The same as devm_gpiod_get_optional() function. Using IS_ERR_OR_NULL()
> check to catch error pointers.
> 
> Fixes: 77131dfe ("Bluetooth: hci_qca: Replace devm_gpiod_get() with devm_gpiod_get_optional()")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
> drivers/bluetooth/hci_qca.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

