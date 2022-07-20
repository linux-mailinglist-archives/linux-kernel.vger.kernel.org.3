Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDB257AF7B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 05:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238783AbiGTD31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 23:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238767AbiGTD3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 23:29:15 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684C943E57;
        Tue, 19 Jul 2022 20:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=P4xF5O0YfncCV5o9E/Adz6pnaqQem+VWuDXhk3O2bPk=; b=eklu/gT4NI8m2bnawZYlSqZ1uU
        Z87zYrp8jGWV04PygQfFdOBzPkjyuQSfQHtvgGstCBgV+nXDiBfRH9gewYOCrb/Dxj1OtMtmjcm5b
        Hh++C8SQJ26D2/IIXhA07oz182v2dGnRAb57i46LLqvGU/wT53++aRwJ0xhpQnlrqT5SEzR4eIvZO
        JeBrQLSkqOq9c1qmcIYAszf/k01jcEPkh9KgDpV4z3mkAMhOOJmyrlTUUspx//fAwmDiWdgybAhmi
        B1npMQ9VN8UKNc+BfBTMJg5mqrXnDzVnWkuUvNlQgmlMNtvqS02yamu3oIitKUktAok00TOmv9bu9
        qKCkcYJA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oE0OZ-00DyI3-S9;
        Wed, 20 Jul 2022 03:29:07 +0000
Date:   Wed, 20 Jul 2022 04:29:07 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Helge Deller <deller@gmx.de>
Cc:     Hillf Danton <hdanton@sina.com>, linux-kernel@vger.kernel.org,
        linux-parisc@vger.kernel.org
Subject: Re: WARNING: CPU: 1 PID: 14735 at fs/dcache.c:365
 dentry_free+0x100/0x128
Message-ID: <Ytd2g72cj0Aq1MBG@ZenIV>
References: <20220709090756.2384-1-hdanton@sina.com>
 <20220715133300.1297-1-hdanton@sina.com>
 <cff76e00-3561-4069-f5c7-26d3de4da3c4@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cff76e00-3561-4069-f5c7-26d3de4da3c4@gmx.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 16, 2022 at 07:27:30AM +0200, Helge Deller wrote:
> On 7/15/22 15:33, Hillf Danton wrote:

> [108565.341434] dentry->d_u.d_rcu = 0x416be770

Incidentally, does that match the address of __d_free() on your build,
or is it something different?
