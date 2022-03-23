Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E9A4E5ACE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 22:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344994AbiCWVqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 17:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237170AbiCWVqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 17:46:32 -0400
Received: from relay4.hostedemail.com (relay4.hostedemail.com [64.99.140.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28FDB8CDA8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 14:45:01 -0700 (PDT)
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay06.hostedemail.com (Postfix) with ESMTP id E8EEC24B1C;
        Wed, 23 Mar 2022 21:45:00 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf12.hostedemail.com (Postfix) with ESMTPA id EF88225;
        Wed, 23 Mar 2022 21:44:59 +0000 (UTC)
Message-ID: <0767836b37030654533fe1a7e8e9b24bc277c176.camel@perches.com>
Subject: Re: [PATCH] get_maintainer: Honor mailmap for in file emails
From:   Joe Perches <joe@perches.com>
To:     Rob Herring <robh@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org
Date:   Wed, 23 Mar 2022 14:44:57 -0700
In-Reply-To: <20220323193645.317514-1-robh@kernel.org>
References: <20220323193645.317514-1-robh@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: EF88225
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: b5cix4zenpy7f15gxua6mrpsgygegm5e
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/NLGH8rCAs2mo6WUD3Ryja8ZiZTczuIiU=
X-HE-Tag: 1648071899-663217
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-03-23 at 14:36 -0500, Rob Herring wrote:
> Add support to also use the mailmap for 'in file' email addresses.

Seems sensible, thanks.

Acked-by: Joe Perches <joe@perches.com>

> 
> Reported-by: Marc Zyngier <maz@kernel.org>
> Cc: Joe Perches <joe@perches.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  scripts/get_maintainer.pl | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
> index 6bd5221d37b8..ab123b498fd9 100755
> --- a/scripts/get_maintainer.pl
> +++ b/scripts/get_maintainer.pl
> @@ -983,6 +983,7 @@ sub get_maintainers {
>  	}
>  
>  	foreach my $email (@file_emails) {
> +	    $email = mailmap_email($email);
>  	    my ($name, $address) = parse_email($email);
>  
>  	    my $tmp_email = format_email($name, $address, $email_usename);


