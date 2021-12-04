Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B03CB468825
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 23:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbhLDXAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 18:00:21 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:33642 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbhLDXAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 18:00:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A0980B80DAE;
        Sat,  4 Dec 2021 22:56:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B513C341C2;
        Sat,  4 Dec 2021 22:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638658612;
        bh=5jjll45Gy0A+y0Ben5Be4GUuntnMaJ9Awp9XCBBWrdU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O7OT2tOmPTppkqtA9d4XunB0pSYzdLUsdGzOIscI5xpLSork6eJIRRyKbHHxTaRB0
         Dmj9rSeFFWA9/xJRhzqvo1KcjSc7vd90ci/85DlY6C/MAVo1Gqd2v44PXyxQyvlpVT
         MwyH7dtByiHanXmNI5cfavr8SK8vUBqxqCaS2vWb9jljxbEx6IHHk2H/wwt5OfdRYz
         h5uE7BfbXSH47WTeO89bxcyqIui0+F0ufJFMomDOhz/wsBhSldYLPIvzHUQN0ihDIG
         x+btjr26fQZRY9FcZ1VtIcfqlqRDQV6VZKaH66+z1cOiFqKNuC1dUYUHJso10TX2fp
         WgtbrBr7bPCiQ==
Date:   Sun, 5 Dec 2021 00:56:48 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org, seanjc@google.com, kai.huang@intel.com,
        cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/25] x86/sgx: Use more generic name for enclave cpumask
 function
Message-ID: <YavyMFUJZKZ9Bpsf@iki.fi>
References: <cover.1638381245.git.reinette.chatre@intel.com>
 <a6667798da726f27e6b63029ab67da1fef5a771e.1638381245.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6667798da726f27e6b63029ab67da1fef5a771e.1638381245.git.reinette.chatre@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

What are "enclave cpumask" and "generic name"? I'd prefer to speak
about concrete things and no use weird rephrasings at all.

Also, renaming is not exporting.

You should split this into two patches:

1. x86/sgx: Export sgx_encl_ewb_cpumask()
2. x86/sgx: Rename sgx_encl_ewb_cpumask() as sgx_encl_cpumask().

/Jarkko
