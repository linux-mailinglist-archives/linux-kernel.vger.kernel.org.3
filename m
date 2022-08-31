Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3B15A8604
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbiHaSq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233110AbiHaSqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:46:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B74146217;
        Wed, 31 Aug 2022 11:46:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1EA1BB8226E;
        Wed, 31 Aug 2022 18:46:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4137DC433C1;
        Wed, 31 Aug 2022 18:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661971598;
        bh=XmS1NgimPQdmBNm5/DBsQT42PoX6m38LeV/44DhDS1M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SNY5E7qqJ8rzSsJKlQbdcAxEilZ8C6k6eG7iLDkSNo1KdB4PAfp4Q59n2oX5xY2Cb
         vk8REeyDawOFYbD943bp9ZPCjalGJ0m7OsAE5rZVpqlgrjVZ9sOtJSZdyZYWQ6NFYh
         pXKqWdn7/CPn2luA9hFqfwM+9tgBTOJCmC8fPsLAFiQ3xJNTh0sFdoaK3vrxGLpxy9
         jdWb4q5XNFIQoHDB7V5XK5M0lBEb0aLVKhDqWAPA201KHq+JfzA7vGw8YerBSZpNnh
         qG3/Muuo9EzQ0mUGdIOPN+g42qJ2xE5+D3cGq0KjbilfrNqNVWEFJ7hZy1iWWyT8ju
         HE/A7nl7g165Q==
Date:   Wed, 31 Aug 2022 21:46:34 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     linux-sgx@vger.kernel.org,
        Haitao Huang <haitao.huang@linux.intel.com>,
        Vijay Dhanraj <vijay.dhanraj@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/6] x86/sgx: Handle VA page allocation failure for
 EAUG on PF.
Message-ID: <Yw+sioB+RdynmlUm@kernel.org>
References: <20220831173829.126661-1-jarkko@kernel.org>
 <20220831173829.126661-4-jarkko@kernel.org>
 <20991fdc-1ae4-ef68-c6d4-12372b4e6f73@intel.com>
 <Yw+mtfFs3dvOWOv2@kernel.org>
 <4c24e461-5ac7-7d79-9764-52f8fdfc311e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c24e461-5ac7-7d79-9764-52f8fdfc311e@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 11:33:26AM -0700, Reinette Chatre wrote:
> Hi Jarkko,
> 
> On 8/31/2022 11:21 AM, Jarkko Sakkinen wrote:
> > 
> > Can you point out what exactly is the whitespace issue?
> 
> There is an extra space after the "=" in:
>        vmret =  VM_FAULT_NOPAGE;

Duh, I did look at it about million times but honestly
did not see it before you pointed it out.

BR, Jarkko
