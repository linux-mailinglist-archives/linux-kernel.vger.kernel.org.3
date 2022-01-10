Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E327C488E57
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 02:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238053AbiAJBvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 20:51:42 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:59303 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238015AbiAJBvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 20:51:33 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JXGyX2TD9z4y4Z;
        Mon, 10 Jan 2022 12:51:32 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Parth Shah <parth@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20220104155450.1291277-1-gregkh@linuxfoundation.org>
References: <20220104155450.1291277-1-gregkh@linuxfoundation.org>
Subject: Re: [PATCH] powerpc/cacheinfo: use default_groups in kobj_type
Message-Id: <164177945934.1604045.10148112415139692856.b4-ty@ellerman.id.au>
Date:   Mon, 10 Jan 2022 12:50:59 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jan 2022 16:54:50 +0100, Greg Kroah-Hartman wrote:
> There are currently 2 ways to create a set of sysfs files for a
> kobj_type, through the default_attrs field, and the default_groups
> field.  Move the powerpc cacheinfo sysfs code to use default_groups
> field which has been the preferred way since aa30f47cf666 ("kobject: Add
> support for default attribute groups to kobj_type") so that we can soon
> get rid of the obsolete default_attrs field.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/cacheinfo: use default_groups in kobj_type
      https://git.kernel.org/powerpc/c/2bdf3f9e9df0a4ce7709fc916b9997ca2dc30d25

cheers
