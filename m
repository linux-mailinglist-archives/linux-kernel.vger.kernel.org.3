Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77E64A6C22
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 08:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbiBBHKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 02:10:24 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:16567 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbiBBHKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 02:10:23 -0500
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220202063441epoutp02968ed1bb9f36ba40595f9cc83bc00954~P5IyKY41d2878428784epoutp02k
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 06:34:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220202063441epoutp02968ed1bb9f36ba40595f9cc83bc00954~P5IyKY41d2878428784epoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643783681;
        bh=OkigBjbJ/hUZbBEBYwYdVxU4vhRxGSoOZRXY6T4zfiI=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=N3UsHnAJPVt4zXKeb7h9I/oXBojyUcGdLZ2rNEH2vK3baQvQ79apvA9vFo++z2Kt4
         FSCUJXClSatz3j4FITWbZ4DX2WWa7UoYTILsk/kH6FaMsI4lWOsPYJ3726J+MnkTGu
         x+FZHI1u6ZMSKe0FMb7CZGEErD6BG9g6axcmRp0M=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220202063440epcas5p24619f00b5d8605edec8300817bd009fc~P5IxOguKg0884508845epcas5p2F;
        Wed,  2 Feb 2022 06:34:40 +0000 (GMT)
X-AuditID: b6c32a49-b01ff70000001917-23-61fa25cadc5c
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B6.B0.06423.AC52AF16; Wed,  2 Feb 2022 15:33:46 +0900 (KST)
Mime-Version: 1.0
Subject: RE: FW: [PATCH v2] scripts/checkpatch.pl: remove _deferred and
 _deferred_once false warning
Reply-To: maninder1.s@samsung.com
Sender: Maninder Singh <maninder1.s@samsung.com>
From:   Maninder Singh <maninder1.s@samsung.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
CC:     "apw@canonical.com" <apw@canonical.com>,
        "joe@perches.com" <joe@perches.com>,
        "dwaipayanray1@gmail.com" <dwaipayanray1@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vaneet Narang <v.narang@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <CAKXUXMyEKXtSde4vJiEKKpjKpcGv7E4LG5WcfjvwsaG3-5Kh9g@mail.gmail.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220202062806epcms5p4d8b2ee8e44369c7670ed89d81ef7c19f@epcms5p4>
Date:   Wed, 02 Feb 2022 11:58:06 +0530
X-CMS-MailID: 20220202062806epcms5p4d8b2ee8e44369c7670ed89d81ef7c19f
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkleLIzCtJLcpLzFFi42LZdlhTS/eU6q9Eg43rxS0+rNWwWL9wGbPF
        7PuPWSwu75rDZtFytJ3F4tDJuYwObB6zGnrZPHbOusvu8WXVNWaPvi2rGD0+b5ILYI3isklJ
        zcksSy3St0vgymhsamEr+MNYsWFXL3sD4zHGLkZODgkBE4nGhtUsXYxcHEICuxklli/5wdbF
        yMHBKyAo8XeHMEiNsECaxPEv3UwgtpCAosSFGWsYQUqEBQwkfm3VAAmzCehJrNq1hwUkLCKg
        LbF1rTTIRGaBD4wS99f9ZYdYxSsxo/0pC4QtLbF9+VawMZwCgRItb00gwqISN1e/ZYex3x+b
        D3WliETrvbPMELagxIOfu6HiMhKrN/eCXS8h0M0osf7dXihnBqNEz6NpUB3mEuuXrAKbyivg
        K/Fq03ZWEJtFQFVi4pErTBA1LhIn/t4BO45ZQF5i+9s5zCDHMQtoSqzfpQ9RIisx9dQ6JogS
        Pone30+YYP7aMQ/GVpVoubmBFebHzx8/Qv3rIbHo2Q5GSDDfYZSY+nsh2wRGhVmIkJ6FZPMs
        hM0LGJlXMUqmFhTnpqcWmxYY5qWW6xUn5haX5qXrJefnbmIEpxYtzx2Mdx980DvEyMTBeIhR
        goNZSYR378LviUK8KYmVValF+fFFpTmpxYcYpTlYlMR5T6dvSBQSSE8sSc1OTS1ILYLJMnFw
        SjUwzfO2zJqTIfj2z4P/QZM27t93VMYwW5r/eMKemdcPXUtwTaiNZYjkE1HQqxQ2/la68N79
        Og0hT/lMryN8Sso1Mx7IRjvkPr99KPzeXG3Na++zvpx2zu1ikjZ/oCBQ2Hzq5pn2bdPym4rd
        pp0MuN6+WE/yXnWFwP22vJAe+a96nxibTDW8TsnOOLvmmeCpaVzcofH8q514AlKZn1fknph9
        78n/ax9/rN7670uWc1a8akFFRHnOzJOdF8KbEv2mVXTzVXPWT9lV8ktxS4CUrp7x6ijx5RfP
        XD0UWPmtW9EmsGODxItVN6+XNRqnrJhw7CDjtWsTJ5cEOdbKKzHz+OU91BeobzONMJUTi1J0
        ZVViKc5INNRiLipOBAB2uk9TnAMAAA==
X-CMS-RootMailID: 20220202044123epcms5p59b0c283f2fe3c7b8654bb600019c1d4f
References: <CAKXUXMyEKXtSde4vJiEKKpjKpcGv7E4LG5WcfjvwsaG3-5Kh9g@mail.gmail.com>
        <20220202044123epcms5p59b0c283f2fe3c7b8654bb600019c1d4f@epcms5p5>
        <CGME20220202044123epcms5p59b0c283f2fe3c7b8654bb600019c1d4f@epcms5p4>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Your email will not reach the mailing list due to the HTML content and picture below. Please set up your email client properly.

Ok, I will resend the patch from git-email again rather than from this email client

Thanks,
Maninder Singh
