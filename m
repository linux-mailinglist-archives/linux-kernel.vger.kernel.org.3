Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8930949CB08
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 14:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240533AbiAZNkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 08:40:41 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:60769 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbiAZNkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 08:40:41 -0500
Received: from smtpclient.apple (p4ff9fc34.dip0.t-ipconnect.de [79.249.252.52])
        by mail.holtmann.org (Postfix) with ESMTPSA id 9D2BECED06;
        Wed, 26 Jan 2022 14:40:39 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH v7 0/2] Bluetooth: hci_h5: btrtl: Add support for
 RTL8822CS hci_ver 0x08
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220126073905.3637841-1-adeep@lexina.in>
Date:   Wed, 26 Jan 2022 14:40:38 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rudi Heitbaum <rudi@heitbaum.com>
Content-Transfer-Encoding: 7bit
Message-Id: <9CE136E5-3BEC-42CB-8A19-644E2B4D0D10@holtmann.org>
References: <20220126073905.3637841-1-adeep@lexina.in>
To:     Vyacheslav Bocharov <adeep@lexina.in>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vyacheslav,

> Add a variation of RTL8822CS with hci_ver = 0x08. This is fully similar
> to RTL8822CS with hci_ver = 0x0a observed on the Tanix TX6 Android set-top
> box and JetHome JetHub H1.
> 
> While testing the RTL8822CS SDIO WiFi/BT adapter, I found that in some
> cases the kernel could not initialize it. However, manually resetting the
> adapter via gpio allows it to start correctly.
> Apparently at system start the adapter is in an undefined state (including
> the unknown state of gpio after starting uboot). A forced reset helps to
> initialize the adapter in most cases. Experimentally it was found that
> 100ms is enough to reset.
> So, add power reset via enable-gpios in h5_btrtl_open function.
> 
> Changes from v6..v4:
> - fix patch description
> Changes from v3:
> - add has_msft_ext option
> Changes from v2:
> - align the patches for bluetooth-next
> Changes from v1:
> - remove Signed-off-by chbgdn <chbgdn@gmail.com> as not reachable
> 
> Vyacheslav Bocharov (2):
>  Bluetooth: btrtl: Add support for RTL8822C hci_ver 0x08
>  Bluetooth: hci_h5: Add power reset via gpio in h5_btrtl_open
> 
> drivers/bluetooth/btrtl.c  | 8 ++++++++
> drivers/bluetooth/hci_h5.c | 5 +++++
> 2 files changed, 13 insertions(+)

both patches have been applied to bluetooth-next tree.

Regards

Marcel

