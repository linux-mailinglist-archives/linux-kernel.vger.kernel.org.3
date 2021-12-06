Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19C78468E82
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 02:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbhLFBTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 20:19:25 -0500
Received: from smtprelay0013.hostedemail.com ([216.40.44.13]:43368 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230037AbhLFBTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 20:19:18 -0500
Received: from omf18.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id E0D0A837F27E;
        Mon,  6 Dec 2021 01:15:49 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf18.hostedemail.com (Postfix) with ESMTPA id 3FA3035;
        Mon,  6 Dec 2021 01:15:49 +0000 (UTC)
Message-ID: <046c27a3937b27c26ece93f835e692c75c7bd1a0.camel@perches.com>
Subject: Re: [PATCH 1/2] kbuild: move headers_check.pl to usr/include/
From:   Joe Perches <joe@perches.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Date:   Sun, 05 Dec 2021 17:15:48 -0800
In-Reply-To: <20211206010533.439981-1-masahiroy@kernel.org>
References: <20211206010533.439981-1-masahiroy@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.28
X-Stat-Signature: cp6das5buajhggpinpn5xd7t9g3z81cb
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 3FA3035
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1//r2SfacN0dVcAk+DHcW9w6pL+soTyi/c=
X-HE-Tag: 1638753349-255956
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-12-06 at 10:05 +0900, Masahiro Yamada wrote:
> This script is only used by usr/include/Makefile. Make it local to
> the directory.
> 
> Update the comment in include/uapi/linux/soundcard.h because
> 'make headers_check' is no longer functional.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  include/uapi/linux/soundcard.h            | 2 +-
>  usr/include/Makefile                      | 2 +-
>  {scripts => usr/include}/headers_check.pl | 0
>  3 files changed, 2 insertions(+), 2 deletions(-)
>  rename {scripts => usr/include}/headers_check.pl (100%)
> 
> diff --git a/include/uapi/linux/soundcard.h b/include/uapi/linux/soundcard.h
[]
> @@ -1051,7 +1051,7 @@ typedef struct mixer_vol_table {
>   *	the GPL version of OSS-4.x and build against that version
>   *	of the header.
>   *
> - *	We redefine the extern keyword so that make headers_check
> + *	We redefine the extern keyword so that scripts/headers_check.pl

Didn't you just move/rename this file?

> diff --git a/scripts/headers_check.pl b/usr/include/headers_check.pl
> similarity index 100%
> rename from scripts/headers_check.pl
> rename to usr/include/headers_check.pl


