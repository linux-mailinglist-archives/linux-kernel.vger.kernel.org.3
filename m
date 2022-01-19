Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6508A4940E8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 20:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240387AbiASTbr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 19 Jan 2022 14:31:47 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:51047 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237219AbiASTbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 14:31:35 -0500
Received: from smtpclient.apple (p4fefca45.dip0.t-ipconnect.de [79.239.202.69])
        by mail.holtmann.org (Postfix) with ESMTPSA id ABCA2CECE1;
        Wed, 19 Jan 2022 20:31:31 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH v4 1/2] Bluetooth: btrtl: Add support for RTL8822C hci_ver
 0x08
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220119061723.2862683-2-adeep@lexina.in>
Date:   Wed, 19 Jan 2022 20:31:31 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rudi Heitbaum <rudi@heitbaum.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <56F74F4D-1916-4F4A-9669-595D3C0A69C7@holtmann.org>
References: <20220119061723.2862683-1-adeep@lexina.in>
 <20220119061723.2862683-2-adeep@lexina.in>
To:     Vyacheslav Bocharov <adeep@lexina.in>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vyacheslav,

> Add a variation of RTL8822CS with hci_ver = 0x08. This is fully similar to RTL8822CS with hci_ver = 0x0a
> observed on the Tanix TX6 Android set-top box and JetHome JetHub H1.
> 
> Changes from v3:
> - add has_msft_ext option

these belong after the --- line. Please see patch submission guidelines.

> 
> Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
> Signed-off-by: Rudi Heitbaum <rudi@heitbaum.com>
> ---
> drivers/bluetooth/btrtl.c | 8 ++++++++
> 1 file changed, 8 insertions(+)

Regards

Marcel

