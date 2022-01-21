Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF0D6496282
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 17:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381739AbiAUQAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 11:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381713AbiAUQAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 11:00:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E55C06173B;
        Fri, 21 Jan 2022 08:00:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D045BB82067;
        Fri, 21 Jan 2022 16:00:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7E36C340E1;
        Fri, 21 Jan 2022 16:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1642780831;
        bh=KmwEb7jWchsW/K1+WMCn24NvCHz3jZARETYvGom7mFI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZGgwbcxrOqaY8HO1bxM0Uzp6CwF9qY1bb1lJbuWa9vbOTuPzEe9hs/eg/FRp0MkMJ
         vzD+e/xpj4lzimqqcMt5vzGxcIP1lQtxHOM3Q9yGMK6Ir0obO35ShPYbAR28EsAnCQ
         Y5sTrqFDhg9ER/3/inri0JZokc8F2ZKoygLvUCLM=
Date:   Fri, 21 Jan 2022 17:00:23 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-spdx@vger.kernel.org" <linux-spdx@vger.kernel.org>
Subject: Re: [PATCH v3] powerpc: Add missing SPDX license identifiers
Message-ID: <YerYl3xPnp7uelS4@kroah.com>
References: <d2c52284244d6dcb3472d2041abe43b456d116df.1642762977.git.christophe.leroy@csgroup.eu>
 <YerEuE6XlslE3Goo@kroah.com>
 <24829c2f-6855-c8d6-7ae4-17c5517f890d@csgroup.eu>
 <YerO8MjbXlvbMEsZ@kroah.com>
 <7d551fc7-0b71-dd34-c489-43bf9e337efb@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7d551fc7-0b71-dd34-c489-43bf9e337efb@csgroup.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 03:34:24PM +0000, Christophe Leroy wrote:
> 
> 
> Le 21/01/2022 à 16:19, Greg Kroah-Hartman a écrit :
> > On Fri, Jan 21, 2022 at 03:13:50PM +0000, Christophe Leroy wrote:
> >>
> >>
> >> Le 21/01/2022 à 15:35, Greg Kroah-Hartman a écrit :
> 
> ...
> 
> >>>> @@ -20,16 +16,6 @@
> >>>>     * respects; for example, they cover modification of the file, and
> >>>>     * distribution when not linked into another program.)
> >>>>     *
> >>>> - * This file is distributed in the hope that it will be useful, but
> >>>> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> >>>> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> >>>> - * General Public License for more details.
> >>>> - *
> >>>> - * You should have received a copy of the GNU General Public License
> >>>> - * along with this program; see the file COPYING.  If not, write to
> >>>> - * the Free Software Foundation, 51 Franklin Street, Fifth Floor,
> >>>> - * Boston, MA 02110-1301, USA.
> >>>> - *
> >>>>     *    As a special exception, if you link this library with files
> >>>>     *    compiled with GCC to produce an executable, this does not cause
> >>>>     *    the resulting executable to be covered by the GNU General Public License.
> >>>
> >>> Look at that "special exception", why are you ignoring it here?  You
> >>> can't do that :(
> >>
> >> I'm not ignoring it, that's the reason why I left it.
> > 
> > You ignore that part of the license in the SPDX line, why?
> > 
> >> Isn't it the correct way to do ? How should it be done ?
> > 
> > You need to properly describe this in the SPDX line.  You did not do so
> > here, which means that any tool just looking at the SPDX line would get
> > this license wrong.
> 
> How do you describe such an exception on the SPDX line then ?
> 
> You add " WITH GCC-exception-2.0" to the SPDX line ? Am I understanding 
> correctly ?

I do not know, please ask the SPDX people.

There's a reason we didn't catch these files in our original sweep, and
that is because they take some manual work.  Which is great to see you
doing, but realize it isn't as simple as your first set of patches were
:)

thanks,

greg k-h
