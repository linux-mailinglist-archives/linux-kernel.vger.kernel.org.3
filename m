Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DED75A999E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 16:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234248AbiIAODB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiIAOC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:02:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FAFCF3;
        Thu,  1 Sep 2022 07:02:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BB482B826DB;
        Thu,  1 Sep 2022 14:02:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E663C433D6;
        Thu,  1 Sep 2022 14:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662040974;
        bh=v04p6wb4CpWCUv9G7qkVV1pCtzU9Pt+eLIyPFIfPVKk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x5cUOwCj8pk/uhRfNp+Sg7IjZvLakYBp1tb/6/pxxgV/V8AjoAFZO8nLX86UORJNi
         FG1xnqTMuVlZxDkzosCAJekFy6Z4tABxswEeVrWxqRxlu+kyzgyVzsK01HjDgGDtUf
         rra0iLLdZMkTXovS5eqHnOhdbDme4xHWSJj+UCx0=
Date:   Thu, 1 Sep 2022 16:02:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Rondreis <linhaoguo86@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: KASAN: use-after-free Read in configfs_composite_bind
Message-ID: <YxC7ix+MerW5xGsB@kroah.com>
References: <CAB7eexLHN1gn2QPdo1_PF70sPbo2cA8skwG17oZb7+J1DQ+J1Q@mail.gmail.com>
 <CAB7eexKGRgDWBLiRs=U70OPLREESi+bCgwt=7wWCESBDZDM=zQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB7eexKGRgDWBLiRs=U70OPLREESi+bCgwt=7wWCESBDZDM=zQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 10:12:38AM +0800, Rondreis wrote:
> sorry forget to sent to lkml earlier
> 
> Rondreis <linhaoguo86@gmail.com> 于2022年8月31日周三 16:08写道：
> >
> > Hello,
> >
> > When fuzzing the Linux kernel driver v5.18.0, the following crash was triggered.

Can you try 5.19.5 please, or Linus's tree?  5.18 is quite old now.

thanks,

greg k-h
