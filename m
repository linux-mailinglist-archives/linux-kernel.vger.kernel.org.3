Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB8DC49BDF3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 22:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbiAYVmN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 25 Jan 2022 16:42:13 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:41409 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbiAYVmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 16:42:11 -0500
Received: from smtpclient.apple (p5b3d24e1.dip0.t-ipconnect.de [91.61.36.225])
        by mail.holtmann.org (Postfix) with ESMTPSA id 15454CECF6;
        Tue, 25 Jan 2022 22:42:10 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH v5 2/2] Bluetooth: hci_h5: Add power reset via gpio in
 h5_btrtl_open
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220125161401.729179-3-adeep@lexina.in>
Date:   Tue, 25 Jan 2022 22:42:09 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rudi Heitbaum <rudi@heitbaum.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <05BB86B6-9E4B-447F-91A3-34224703176C@holtmann.org>
References: <20220125161401.729179-1-adeep@lexina.in>
 <20220125161401.729179-3-adeep@lexina.in>
To:     Vyacheslav Bocharov <adeep@lexina.in>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vyachselav,

> Add power reset for bluetooth via enable-gpios in h5_btrtl_open function.
> 
> Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
> ---
> 
> While testing the RTL8822CS SDIO WiFi/BT adapter, I found that in some
> cases the kernel could not initialize it. However, manually resetting the
> adapter via gpio allows it to start correctly.
> Apparently at system start the adapter is in an undefined state (including
> the unknown state of gpio after starting uboot). A forced reset helps to
> initialize the adapter in most cases. Experimentally it was found that
> 100ms is enough to reset.

if you put this here, then this information is lost. So move it to the commit message.

Regards

Marcel

