Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA32547A504
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 07:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237563AbhLTGaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 01:30:02 -0500
Received: from st43p00im-ztdg10073201.me.com ([17.58.63.177]:37305 "EHLO
        st43p00im-ztdg10073201.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237557AbhLTGaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 01:30:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1639981801; bh=RR34LXkEm3FYOkGWrqOMUZuOhbZI/ysAAFPSFvd75BU=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=SlzofpH57ekpBxSDY7UlhZFqN5rqbE3w4KIOT3zc31XVgUOpBuT6TCVl6/lpmeOOo
         PqvCUEmfa5ccALcgcPJj/CU3zLQ/T/kEPn6DcAg8bfUlo0HMNoRRIbiizyLdVHgwGB
         1Dq+pxOfp6BTxvmuPzQY7LZrnmBAju1aZHK6THmxDQbNOcCDggYyaJ+/71f5wMOG2h
         9IZtzvWvo5fZBoLTUWKkhUttgEJOSt6H4h1gEzef0B6zPWg324TzYkyJaR5zAmUoNQ
         Fz31+i7CIT0cV/Kd3ZaHUlJl+ThYFq0fDQ3QJQM5O/0TZVmZeXU+nVV8sx9+DZR57A
         iY4jTxsPdX/+Q==
Received: from gnbcxl0045.gnb.st.com (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-ztdg10073201.me.com (Postfix) with ESMTPSA id 5C04E222047;
        Mon, 20 Dec 2021 06:29:59 +0000 (UTC)
Date:   Mon, 20 Dec 2021 07:29:55 +0100
From:   Alain Volmat <avolmat@me.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Patrice Chotard <patrice.chotard@foss.st.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: st: fix comments compilation warnings
Message-ID: <20211220062955.GA198368@gnbcxl0045.gnb.st.com>
Mail-Followup-To: Linus Walleij <linus.walleij@linaro.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211218212512.196866-1-avolmat@me.com>
 <CACRpkdaAefLm_SxtbryDdGopr8WfVZkJmg4y8-w-WJuJqE-u1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdaAefLm_SxtbryDdGopr8WfVZkJmg4y8-w-WJuJqE-u1w@mail.gmail.com>
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.790,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2021-12-20=5F02:2021-12-16=5F01,2021-12-20=5F02,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=917 bulkscore=0 spamscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2112200035
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

apologies. Indeed those two warnings are already fixed in your
devel branch.  This patch is thus no more necessary.

Regards,
Alain

On Mon, Dec 20, 2021 at 03:17:46AM +0100, Linus Walleij wrote:
> On Sat, Dec 18, 2021 at 10:25 PM Alain Volmat <avolmat@me.com> wrote:
> 
> > This commit fixes 2 compilation warnings due to comment starting with
> > /** while not being kernel-doc comments.
> >
> > drivers/pinctrl/pinctrl-st.c:59: warning: This comment starts with '/**',
> > but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
> >  *  Packed style retime configuration.
> > drivers/pinctrl/pinctrl-st.c:73: warning: This comment starts with '/**',
> > but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
> >  * Dedicated style retime Configuration register
> >
> > Signed-off-by: Alain Volmat <avolmat@me.com>
> 
> This does not apply on my "devel" branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/log/?h=devel
> 
> Please rebase and resend.
> 
> Yours,
> Linus Walleij
