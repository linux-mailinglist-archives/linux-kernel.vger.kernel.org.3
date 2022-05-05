Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD24951C168
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 15:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380135AbiEENyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 09:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380128AbiEENym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 09:54:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE0657145;
        Thu,  5 May 2022 06:51:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5146961E9A;
        Thu,  5 May 2022 13:51:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F7FC385A4;
        Thu,  5 May 2022 13:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651758660;
        bh=iPXVsUeefsSXMgAyzKINU9dFR0i49AXp7kY8lMNocSY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kICzedcjShQGtfptdoI3ZF6md244nv/qOUtAG75Vfr84Rte56ijtdFWkysZ3hCSC0
         ftzgZksXOOKaUW2+zzxmQJdZEdFMC33cdsXZxhaiBQfedW0T9OJP0QfQ3BqlQB3x3K
         1jHTCNgPyUyV/8DQD/dEbcVghPCzMfHY9hKt22QdTZdFu8cGixph6U5FeNTAHJmgiF
         VPuRwwVWFw36bLkWqTJ6rl4bV6gVGHm3MRAJVcZz/HZABXoILJB9zk8GLl84eo7x2d
         gawfKya/kmLxCSpiBdU/DMJq/LqfCWWXfnzRbanCjKZau2+qb4OgCw0vSdc9UAGDrs
         W/W6K1x7zjBpQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nmbsi-0008EU-KU; Thu, 05 May 2022 15:51:01 +0200
Date:   Thu, 5 May 2022 15:51:00 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Ethan Yang <etyang@sierrawireless.com>
Cc:     =?utf-8?B?55qT5a6HIO+/vQ==?= <ipis.yang@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Glen Chiang <GChiang@sierrawireless.com>
Subject: Re: [PATCH v3] usb: serial: qcserial: add support for Sierra
 Wireless EM7590
Message-ID: <YnPWRJT+NoxQcp7a@hovoldconsulting.com>
References: <YmYvPXeqQzyms91m@kroah.com>
 <20220425055840.5693-1-etyang@sierrawireless.com>
 <YnO1NHWCFCIfydBI@hovoldconsulting.com>
 <BL0PR02MB4451F88B384BA9D7FCE6A7C3ABC29@BL0PR02MB4451.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL0PR02MB4451F88B384BA9D7FCE6A7C3ABC29@BL0PR02MB4451.namprd02.prod.outlook.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 12:35:41PM +0000, Ethan Yang wrote:
> Hi Johan,
> 
> Here is the change log:
> To revise the correct composition for QDL/APP mode.
> 1199:c080 is for QDL, and 1199:c081 is for APP mode.

I meant that when you when you resend a new version of a patch you
should include a changelog for what changed since the previous
version(s) (below the --- line).

In this case I think you only changed the From address from v1 to v2,
but I'm not sure.

No need to resend, but please keep that in mind for your future
submissions.

> I also enclose the lsusb -v output for both compositions.

Thanks a lot for that.

I've applied the patch now.

Johan
