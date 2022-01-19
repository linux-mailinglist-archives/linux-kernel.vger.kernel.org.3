Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3F774940EC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 20:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241622AbiASTc3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 19 Jan 2022 14:32:29 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:35564 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241392AbiASTc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 14:32:27 -0500
Received: from smtpclient.apple (p4fefca45.dip0.t-ipconnect.de [79.239.202.69])
        by mail.holtmann.org (Postfix) with ESMTPSA id C4B06CECE1;
        Wed, 19 Jan 2022 20:32:25 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH v4 2/2] Bluetooth: hci_h5: Add power reset via gpio in
 h5_btrtl_open
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220119061723.2862683-3-adeep@lexina.in>
Date:   Wed, 19 Jan 2022 20:32:25 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <2591AB28-2072-4345-907D-17AAA49B21CE@holtmann.org>
References: <20220119061723.2862683-1-adeep@lexina.in>
 <20220119061723.2862683-3-adeep@lexina.in>
To:     Vyacheslav Bocharov <adeep@lexina.in>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vyacheslav,

> Add power reset via enable-gpios in h5_btrtl_open function.

this is too sparse commit message. Add explation and if possible also references on why that is needed.

Regards

Marcel

