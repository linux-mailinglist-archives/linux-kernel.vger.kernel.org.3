Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D95496C47
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 13:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234489AbiAVMLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 07:11:12 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:42697 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229514AbiAVMLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 07:11:11 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id B99D95C0156;
        Sat, 22 Jan 2022 07:11:10 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 22 Jan 2022 07:11:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm2; bh=0
        4G5CcShqixtcjS9thUwmKtBaIQAOrFakrRTKIPU5XM=; b=p7rxeKUCduyoHqPhq
        f9z9kD5ijspgCCznlN59UWqNAXji8fhgetnhHRr5E2ndOgKjo0W9RpCecVQ1U/dF
        OVuqhSZQ7VJY/HfVC8TXFP7RH1y4GPn4XWKSXKVAdxRYSM0Uug5+nH+UZnkb/qbx
        gDMpY0Qp9PVmwmlhrdxZfk8ggi4CNC34ujltU5bKCdz+oPpF4NEzkI6LvLVaieaW
        M54kCS50/JzrxEyN4cM//1t68+ChQJeC1WN/UUu4c4/JTnfzbTW3rtsXdeufeX2M
        XSouxBUu6odeosNO+U77kdEe0owUMIZPPUD4cdwpx8suM89HUFcyneclSh7gfpV3
        Gd+Kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=04G5CcShqixtcjS9thUwmKtBaIQAOrFakrRTKIPU5
        XM=; b=L0hoen79Xjy7xYQE7ifQ79XUxE6SfVpibsB5e4yb2kfCoCK4O2LBw0B6s
        iFMFFfVTOzFLmjQSAcnBujZrXQpi78fRbU585bAoDGL3Odf0oJc3VCTqe+kZkFqO
        ZQWzIhPsY+FkG15BpIoj6UhC+/c6UMfmgxnZMrx34ZaqtXMt1RNZJX7z92lFOXBQ
        2D3U7lYYTlZf8XyO6kUvcIgwEnV0sC3QOYNs1WBgsulrY9eAkaK+k3JRCiIPtHWl
        b4xc4EBV8+nXAag4OW7aGWgOc7OAZDf2r3x5k8iW88JnuAWVJp7QLAZGyvlJ8DIk
        FvpouSzxmwUVO7FODwMw/CoeL4m7Q==
X-ME-Sender: <xms:XvTrYRvUcCfpfayTccUsdsaHJcmB536FUUp5tGYR7sj8v1RMHtrcPA>
    <xme:XvTrYaetdGSP2WB2DR4ExO5ZcsmG0ZU0SqTZgeor3nO0IpY501w7qxWbXDDU2_f_R
    h0z0l9kdoUe0A>
X-ME-Received: <xmr:XvTrYUxSBnki2IoxhfS8YwaSJRY5AaINchRDi5m_2-BNk80ktnhJkD3Nk3AG1DbHMOzVn6MqiBu_mf_77ERdtnx0kr_gx9U0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrvddvgdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkgggtugesthdtredttddtvdenucfhrhhomhepifhrvghgucfmjfcu
    oehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepvedugeeuffelge
    ekhfehtdefhfekffdtgedvteeitddvieduhfekheekueehleelnecuffhomhgrihhnpehk
    rhhorghhrdgtohhmpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:XvTrYYO-lECTGUMp4a14vAtnYKaczzR7Ta_lRpR2V4Y_QSWy3oiCag>
    <xmx:XvTrYR-Uhpny-kMD6g0aZof6gWaMR4Yz1s3CsupcPQCtrhTwewAg2g>
    <xmx:XvTrYYWH2zapvMCH2ntvdMwnNh9nLm3qpwJMCVA73uc-fWiPyajtHA>
    <xmx:XvTrYdbvtcUNoRzk0RcqTjCs-RQaQYRczwx_GyJe-Cmbw-rLUhSr6g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 22 Jan 2022 07:11:09 -0500 (EST)
Date:   Sat, 22 Jan 2022 13:11:08 +0100
From:   Greg KH <greg@kroah.com>
To:     linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Matthias Gerstner <mgerstner@suse.de>
Subject: usbview 3.0 release
Message-ID: <Yev0XJ7qs6xTNQQ9@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hot on the heels of the 2.2 release, here is "3.0", with an entirely
rewritten back-end where the USB data is read from.  No longer is
debugfs access needed, all of the information is taken directly from
sysfs as normal user permissions.

This should allow distros and packagers to no longer need polkit
policies at all, and hopefully remove any potential future problems in
the tool.

The package can be downloaded at:
	http://www.kroah.com/linux/usb/usbview-3.0.tar.gz
and the git tree can be found at:
	http://github.com/gregkh/usbview

thanks,

greg k-h

-------

version 3.0
	- remove need for debugfs/usbdevfs/usbfs file entirely, rely only on
	  sysfs now.  This removes the need to run the program as root, which
	  should have never happened.
	- added SPDX identifiers and .spdx file to make packaging easier for
	  others.
