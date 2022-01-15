Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D766C48F68C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 12:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbiAOLdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 06:33:40 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:53641 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiAOLdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 06:33:40 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 97B6D223ED;
        Sat, 15 Jan 2022 12:33:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1642246418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0KEFXqu+fzFHJgxY8mspyC5L+cr7ncawgm58PL7n558=;
        b=tasuua0gVD9X6RSR2RGaMo/kNHNK0BYw26hcPk8YjcEHV0LiuMd7KwqbuTYShyYfJ/KYXW
        iwO9K9x763ROBSEd3dMl1GHGCi1l7Q8wPk9VkLIpXCDn1MlweMIImDEviExxHvxCKLF8GU
        Nvga/QmzEo/YFkGgESpcyN9r5OU78ZI=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 15 Jan 2022 12:33:38 +0100
From:   Michael Walle <michael@walle.cc>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Rob Herring <robherring2@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the devicetree tree
In-Reply-To: <20220115153212.593f534d@canb.auug.org.au>
References: <20220115153212.593f534d@canb.auug.org.au>
User-Agent: Roundcube Webmail/1.4.12
Message-ID: <668e68d07c114435f680eafd5444e1e3@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 2022-01-15 05:32, schrieb Stephen Rothwell:
> After merging the devicetree tree, today's linux-next build (htmldocs)
> produced these warnings:
> 
> include/linux/of.h:1037: warning: Function parameter or member 'np'
> not described in 'of_parse_phandle_with_optional_args'
> include/linux/of.h:1037: warning: Function parameter or member
> 'list_name' not described in 'of_parse_phandle_with_optional_args'
> include/linux/of.h:1037: warning: Function parameter or member
> 'cells_name' not described in 'of_parse_phandle_with_optional_args'
> include/linux/of.h:1037: warning: Function parameter or member 'index'
> not described in 'of_parse_phandle_with_optional_args'
> include/linux/of.h:1037: warning: Function parameter or member
> 'out_args' not described in 'of_parse_phandle_with_optional_args'
> 
> Introduced by commit
> 
>   952c4865d27a ("of: base: add of_parse_phandle_with_optional_args()")

Sorry about that, just sent a fixes patch:
https://lore.kernel.org/linux-devicetree/20220115113156.435037-1-michael@walle.cc/

-michael
