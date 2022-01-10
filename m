Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D854488E58
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 02:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238069AbiAJBvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 20:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238034AbiAJBvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 20:51:35 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018DDC06173F
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 17:51:35 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JXGyY1Bg6z4y4f;
        Mon, 10 Jan 2022 12:51:33 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
        Joel Stanley <joel@jms.id.au>, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20220104161318.1306023-1-gregkh@linuxfoundation.org>
References: <20220104161318.1306023-1-gregkh@linuxfoundation.org>
Subject: Re: [PATCH] powerpc/opal: use default_groups in kobj_type
Message-Id: <164177946012.1604045.1654881148471934534.b4-ty@ellerman.id.au>
Date:   Mon, 10 Jan 2022 12:51:00 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jan 2022 17:13:18 +0100, Greg Kroah-Hartman wrote:
> There are currently 2 ways to create a set of sysfs files for a
> kobj_type, through the default_attrs field, and the default_groups
> field.  Move the powerpc opal dump and elog sysfs code to use
> default_groups field which has been the preferred way since aa30f47cf666
> ("kobject: Add support for default attribute groups to kobj_type") so
> that we can soon get rid of the obsolete default_attrs field.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/opal: use default_groups in kobj_type
      https://git.kernel.org/powerpc/c/32a1bda4b12a3d324bd585e1aa20dac824ab719c

cheers
