Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38A2C48E818
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 11:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237624AbiANKII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 05:08:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237634AbiANKIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 05:08:07 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358BFC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 02:08:07 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 4BA242223A;
        Fri, 14 Jan 2022 11:08:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1642154884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O4jyvlhZ8Yykl40vYuWgq6f+Jtd8TCx2/U599wgdVMI=;
        b=kEyL4muFvDHSteF7Qnesk2Cp1FkdOJ5a/yFCjlh70Ca+vxb0xfCi7OHAWLsMqfRGNrWJlD
        yMt2QjbL1aoYFF42om5tsVnQwP0uxxFuOi01/FEQCf7YCX62ZmaQhPu2+4S2CPkFQBrRpD
        Fj35Dlo3vF2+U3aeBhyHkl4WaUH45vI=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 14 Jan 2022 11:08:03 +0100
From:   Michael Walle <michael@walle.cc>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Stefan Schaeckeler <schaecsn@gmx.net>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH] ubifs: use default_groups in kobj_type
In-Reply-To: <20220113180857.2158974-1-gregkh@linuxfoundation.org>
References: <20220113180857.2158974-1-gregkh@linuxfoundation.org>
User-Agent: Roundcube Webmail/1.4.12
Message-ID: <bafc94269e6fa7632bc6ea458320b238@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 2022-01-13 19:08, schrieb Greg Kroah-Hartman:
> There are currently 2 ways to create a set of sysfs files for a
> kobj_type, through the default_attrs field, and the default_groups
> field.  Move the AMD mce sysfs code to use default_groups field which

copy & paste mistake?

> has been the preferred way since aa30f47cf666 ("kobject: Add support 
> for
> default attribute groups to kobj_type") so that we can soon get rid of
> the obsolete default_attrs field.

-michael
