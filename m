Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4894EFBD5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 22:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352672AbiDAUwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 16:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352644AbiDAUwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 16:52:23 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608091C34B2
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 13:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=pxgCiH3UBMhEA+7hBaFKYNTUMBk/ZSn4IjZNt2Xtw30=; b=f8jiMnT53JzcF2f+FBDri2/NRV
        4qeN+gnzm8riYEXkfmLpsbfzgyvwQDK4t9dXzMeI+GilYK26FXxPlFt/g4AILQaVwLrYApm0HPgNW
        Z5uHUfeVdJnOijj0NWf1HIsZvhJNoCO7RKypUBov0mmn6RIPt5Rig6zff3s1g3akPHm5+UvznmcO8
        qZ2AYzs28TbjilVoyUI6vJc9Wdnpgslj0FcTh/dsYrk0sWh+6Nq8P2FmU+ZRKdkv1VlsVCkCXN8hM
        aBMN6FytwpX8SG20dzhurDEhf7wnd44eFr4Sm13ILH9qb7Iu+2SShr31HS/f80PhSSaaH9AaqZu/C
        d8jHT5Tw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1naODs-000gU6-EE; Fri, 01 Apr 2022 20:50:21 +0000
Message-ID: <520eaf08-892e-8ce0-4dca-ad8febc3d6af@infradead.org>
Date:   Fri, 1 Apr 2022 13:50:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] checkpatch: add warning for non-lore mailing list URLs
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
References: <20220401201417.126664-1-helgaas@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220401201417.126664-1-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/1/22 13:14, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> The lkml.org, marc.info, spinics.net, etc archives are not quite as useful
> as lore.kernel.org because they use different styles, add advertising, and
> may disappear in the future.  The lore archives are more consistent and
> more likely to stick around, so prefer https://lore.kernel.org URLs when
> they exist.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
> 
> Thanks to Joe for fixing the quoting:
> https://lore.kernel.org/all/3e21b6e87e219d6538a193a9021b965fd8180025.camel@perches.com/
> Sorry I totally dropped the ball -- I guess I was scared off by fixing the
> perl quoting and didn't notice that you actually did it for me ;)
> 
> Sample commits for testing with "checkpatch -g":
> 
>   bd82d4bd2188 www.spinics.net/lists/arm-kernel/msg716956.html
>   fdec2a9ef853 www.spinics.net/lists/kvm-arm
>   1cdca16c043a www.spinics.net/lists/linux-mmc
>   48ea02184a9d www.spinics.net/lists/linux-pci
>   f32ae8a5f131 www.spinics.net/lists/netdev
>   b7dca6dd1e59 lkml.org
>   265df32eae58 lkml.org/lkml/
>   4a9ceb7dbadf marc.info/?l=linux-kernel&m=155656897409107&w=2.
>   c03914b7aa31 marc.info/?l=linux-mm
>   f108c887d089 marc.info/?l=linux-netdev
>   7424edbb5590 marc.info/?t=156200975600004&r=1&w=2
>   dabac6e460ce https://marc.info/?l=linux-rdma&m=152296522708522&w=2
>   b02f6a2ef0a1 www.mail-archive.com/linux-kernel@vger.kernel.org
>   5e91bf5ce9b8 lists.infradead.org/pipermail/linux-snps-arc/2019-May
>   3cde818cd02b mailman.alsa-project.org/pipermail/alsa-devel/2019-January/144761.html
>   a5448fdc469d http://lists.infradead.org/pipermail/linux-nvme/2019-June/024721.html
> ---
>  scripts/checkpatch.pl | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 577e02998701..819e0dece5e9 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -698,6 +698,17 @@ sub find_standard_signature {
>  	return "";
>  }
>  
> +our $obsolete_archives = qr{(?xi:
> +	\Qfreedesktop.org/archives/dri-devel\E |
> +	\Qlists.infradead.org\E |
> +	\Qlkml.org\E |
> +	\Qmail-archive.com\E |
> +	\Qmailman.alsa-project.org/pipermail\E |
> +	\Qmarc.info\E |
> +	\Qozlabs.org/pipermail\E |
> +	\Qspinics.net\E
> +)};

Hi,

There seem to be some mailing lists from lists.infradead.org that are not (yet?)
archived on lore.
Is there a plan to add more list archives from infradead to lore?

thanks.

> +
>  our @typeListMisordered = (
>  	qr{char\s+(?:un)?signed},
>  	qr{int\s+(?:(?:un)?signed\s+)?short\s},
> @@ -3273,6 +3284,12 @@ sub process {
>  			$last_git_commit_id_linenr = $linenr if ($line =~ /\bcommit\s*$/i);
>  		}
>  
> +# Check for mailing list archives other than lore.kernel.org
> +		if ($rawline =~ m{\b$obsolete_archives}) {
> +			WARN("PREFER_LORE_ARCHIVE",
> +			     "Use lore.kernel.org archive links when possible - see https://lore.kernel.org/lists.html\n" . $herecurr);
> +		}
> +
>  # Check for added, moved or deleted files
>  		if (!$reported_maintainer_file && !$in_commit_log &&
>  		    ($line =~ /^(?:new|deleted) file mode\s*\d+\s*$/ ||

-- 
~Randy
