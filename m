Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11839490393
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 09:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238000AbiAQIRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 03:17:23 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45812 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233253AbiAQIRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 03:17:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64BA5B80DF2;
        Mon, 17 Jan 2022 08:17:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66080C36AE7;
        Mon, 17 Jan 2022 08:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1642407440;
        bh=7V2uwOg2XQE1qErJ/nwZj130Wi+eTJqoL9PiUIS/Pns=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ARIRBjMGLNFTzyzqbzZQTigMaGQKjAFdQ0c4oJ4IhKR/qZYM8DV6yeq+hcYK5JfXA
         MILnT071KlV1itZZMKNAiiFe/jzhUn3qA9tEbN7YrC2S/Zs3Cr7yu3NxPy+wrawLju
         SNmb/dPtxcYjASeq6EnT8mZ0l6NDJNcJzC0iEKb4=
Date:   Mon, 17 Jan 2022 09:17:17 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-spdx@vger.kernel.org" <linux-spdx@vger.kernel.org>
Subject: Re: [PATCH v2] powerpc: Add missing SPDX license identifiers to DTS
 files
Message-ID: <YeUmDV8vgHO592qt@kroah.com>
References: <633873803244c2122381cb11228a6a9a7385abd4.1642402958.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <633873803244c2122381cb11228a6a9a7385abd4.1642402958.git.christophe.leroy@csgroup.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 07:03:45AM +0000, Christophe Leroy wrote:
> Several DTS files are missing SPDX license identifiers.

Normally DTS files are not just GPLv2, are you sure this is intended?

> 
> For files in fsl/ subdirectory, GPL v2 or later is used based
> on the comments in the files.

You do not seem to have gotten the license correct for these, the text
in the file comments disagrees with GPLv2+ only.

Please be VERY careful when adding license tags to files like this, if
this patch was accepted it would get very confusing as they are
contradictions in the file itself suddenly.

Also, when adding SPDX lines, remove the boiler-plate license text at
the same time so that we can verify that the SPDX line is correct.  If
you had done that here, it would be obvious that the patch is incorrect.

As-is, this patch is not acceptable, sorry.

greg k-h
