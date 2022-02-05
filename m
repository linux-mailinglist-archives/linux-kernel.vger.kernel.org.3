Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068234AAC7B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 21:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353612AbiBEUcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 15:32:43 -0500
Received: from mx1.riseup.net ([198.252.153.129]:43790 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232428AbiBEUcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 15:32:41 -0500
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4Jrkc94mmKzDxn4
        for <linux-kernel@vger.kernel.org>; Sat,  5 Feb 2022 12:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1644093161; bh=ukKbQ58sWJNsbPgEna48t+5h6SxlxFHd/Q6rBjra2l8=;
        h=Date:To:From:Subject:From;
        b=IZoRddOLkDYiUhbINpPv16WAY8izds3HWwZ4XUjLtKF7U3NQqvFYZXAPblQrrkqUe
         cgzVbwbHbHOqpd23k26fcrznoqa8cEbAQA8u7mYRBa1LN0Vh0mhrONCvkGJzh73gTE
         SXST6FMMwKsNUOUIlPfkS5yua7q8xgHzAnWuYdmk=
X-Riseup-User-ID: 0E82E722786199E9B0FDD018B3E29220AA3784ED216CEBD2E8FB0BB9BE6E2709
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4Jrkc844RHz5vLd
        for <linux-kernel@vger.kernel.org>; Sat,  5 Feb 2022 12:32:40 -0800 (PST)
Message-ID: <6299d769-331c-ace9-bc56-2fe601f47576@riseup.net>
Date:   Sat, 5 Feb 2022 21:32:36 +0100
MIME-Version: 1.0
To:     linux-kernel@vger.kernel.org
Content-Language: de-DE
From:   =?UTF-8?B?S2FpIEzDvGtl?= <kailueke@riseup.net>
Subject: 5.15 memory corruption issue
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I named the filed issue "list_del corruption" but it could just be a 
symptom:

https://bugzilla.kernel.org/show_bug.cgi?id=215571

Since I could not reproduce it with 5.16 I think there might be a fix 
that wasn't backported (or it was fixed "accidentally", or the bug got 
introduced in 5.15 it was branched?).

Regards,
Kai

