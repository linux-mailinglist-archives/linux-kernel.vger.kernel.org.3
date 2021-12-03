Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86731466EAF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 01:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350105AbhLCAtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 19:49:31 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:42089 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238220AbhLCAt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 19:49:29 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 9A4785C011D;
        Thu,  2 Dec 2021 19:46:06 -0500 (EST)
Received: from imap44 ([10.202.2.94])
  by compute5.internal (MEProxy); Thu, 02 Dec 2021 19:46:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type:content-transfer-encoding; s=fm3; bh=YPHKg
        0tcsMsw3+/5ECgto/EzakVJuVTXtf6xXT7Vbt8=; b=svMqKrdL/FUSUrgKnz185
        gK6lGzuNro4jnW0LRsj9j21qMmoQjMUpvGHL6pMn9/SgXHn2DM1qhJZlc6LkgLzd
        rRNy2XvAL3v0J/g32KJPqZ8yPqzvHJyyO9gAvuegLrYMPYbTMVIi+/D+4oAxHNQH
        F+ljILY3ep/0ZEkviqteQYZqRTFtCp3euUGDPXpT+P27gyXh4xkyfvRaSnI6o2vN
        df6SwuPz7lGKwCSPlrKx4y8xDwXVaVRQYWbKtpuiCNBfrertlcfog4uslfi+d8Hb
        4ZpWtD0RXJpdPeJn+YKb1kQ+f3Ix90DEUDrF8XD9HWQ2Eks+n+VqxZ+6ErUwx4TR
        Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=YPHKg0tcsMsw3+/5ECgto/EzakVJuVTXtf6xXT7Vb
        t8=; b=Rfh39d71O7lIlShNLzYv37FLklibG72T1XBUDysw0J982SPhYLbntXt0j
        pVJc6lJMTCHrIpc5vlhS2RhPcPGGFNw+n9AEWG+EE2TqwuY2KXNMpDxVOun3B9H+
        YzgX3LvQKhpT+UwtF1nXjPdTz5ww7PBhvbdhk4eGiw/H15idAO+j15kjdI9YPOFi
        9anjz60+lAtqiU8R8p+H48ABk0eLS1qfsXEUOu0Z1gbnpwXDEHVAXCyMuV2PabqY
        tayltJgKf1D1aR/hnj5weRAN2oPJvK/jXN1G8sQ0mP8jMEOWfXQCi1iVzYQgltQl
        eVxXYNvR1v2jfac8LtvjCMxOwxS9w==
X-ME-Sender: <xms:zmipYQjyvtR6PD5QoUK9FSPfLUgNqFb0vTai688lpUYAZ5MI8mBpgg>
    <xme:zmipYZBZFnoju21Evw7cxsaXd6cPwfCStNsQRpp_58LmVxneJVAhGvycNR-iURFYE
    mfjvMRtE7fiRmRStIo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrieeigddvhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdflihgr
    gihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
    enucggtffrrghtthgvrhhnpeefteegkeevfeethffgudehgedvueduvdeifedvvdelhfef
    heekteefueektdefjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:zmipYYHaG3hBKk1MKeNMsW2DC6w6dMzZaMdEeSxLzpMxD-7tJ8vZiA>
    <xmx:zmipYRRb-7sgokWbx2RX2uuRrWVCL35GTDqrwDDTKiQLsVZ9oJbz7Q>
    <xmx:zmipYdyDjWhRjTZM1hKsQMRzRRtwJJKLs5G98SxGtUKogFCi7dnOIQ>
    <xmx:zmipYUnpbNm2YVfSfrDAMGnhFMFtIKTpKztnU37FRxDCfyP_2Tct-w>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6E6CCFA0AA6; Thu,  2 Dec 2021 19:46:06 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4458-g51a91c06b2-fm-20211130.004-g51a91c06
Mime-Version: 1.0
Message-Id: <27b6387f-fa93-484e-a56e-12452a82f069@www.fastmail.com>
In-Reply-To: <822ced92-f165-3c5a-e0bf-dafa6f808b76@intel.com>
References: <20211203003636.11417-1-jiaxun.yang@flygoat.com>
 <822ced92-f165-3c5a-e0bf-dafa6f808b76@intel.com>
Date:   Fri, 03 Dec 2021 00:45:44 +0000
From:   "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To:     "Dave Hansen" <dave.hansen@intel.com>, x86@kernel.org
Cc:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        chang.seok.bae@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 00/10] x86: Allocate AVX512 xstate ondemand
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=E5=9C=A82021=E5=B9=B412=E6=9C=883=E6=97=A5=E5=8D=81=E4=BA=8C=E6=9C=88 =E4=
=B8=8A=E5=8D=8812:40=EF=BC=8CDave Hansen=E5=86=99=E9=81=93=EF=BC=9A
> On 12/2/21 4:36 PM, Jiaxun Yang wrote:
>> Also we are going to have heterogeneous processors that
>> only some cores support AVX512, it can be helpful when
>> dealing with such processors.
>
> Really?  Which x86 vendor is doing that?

Clear lower two bits of MSR 0xAF on Alder Lake give me some suprise :-)

--=20
- Jiaxun
