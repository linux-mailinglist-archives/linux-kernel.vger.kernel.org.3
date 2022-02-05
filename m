Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D7E4AA5FF
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 03:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240984AbiBECoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 21:44:19 -0500
Received: from relay5.hostedemail.com ([64.99.140.40]:40360 "EHLO
        relay5.hostedemail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235383AbiBECoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 21:44:14 -0500
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay02.hostedemail.com (Postfix) with ESMTP id 4B4E2232EE;
        Sat,  5 Feb 2022 02:44:13 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf14.hostedemail.com (Postfix) with ESMTPA id 742812F;
        Sat,  5 Feb 2022 02:43:57 +0000 (UTC)
Message-ID: <b2aeaf001ad7551b902fc1d366abce71f94d49d6.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: Add RTLA entry
From:   Joe Perches <joe@perches.com>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 04 Feb 2022 18:44:10 -0800
In-Reply-To: <50d8870522580905a1c7f3e6fb611a700f632af1.1643994005.git.bristot@kernel.org>
References: <50d8870522580905a1c7f3e6fb611a700f632af1.1643994005.git.bristot@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Stat-Signature: twsa77u64efx3jz5gqf3zxz5sez1jscc
X-Spam-Status: No, score=-3.66
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 742812F
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+8p+WoQeft1jhqNsBCoPAjCG0YSuapzXk=
X-HE-Tag: 1644029037-606597
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-02-04 at 18:18 +0100, Daniel Bristot de Oliveira wrote:
> Add an RTLA entry in the MAINTAINERS file with Steven Rostedt and
> myself as maintainers.
[]
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -19581,6 +19581,14 @@ F:	Documentation/trace/timerlat-tracer.rst
>  F:	Documentation/trace/hwlat_detector.rst
>  F:	arch/*/kernel/trace.c
>  
> +Real-time Linux Analysis (RTLA) tools
> +M:	Daniel Bristot de Oliveira <bristot@kernel.org>
> +M:	Steven Rostedt <rostedt@goodmis.org>
> +L:	linux-trace-devel@vger.kernel.org
> +S:	Maintained
> +F:	tools/tracing/rtla
> +F:	Documentation/tools/rtla

ideally both of these F: entries would have a trailing slash

F:	tools/tracing/rtla/
F:	Documentation/tools/rtla/


