Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB0954FD3B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 21:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237559AbiFQTGV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 17 Jun 2022 15:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236869AbiFQTGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 15:06:09 -0400
Received: from relay3.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D184CD78
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 12:06:07 -0700 (PDT)
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay12.hostedemail.com (Postfix) with ESMTP id 3CA7B120789;
        Fri, 17 Jun 2022 19:06:06 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf01.hostedemail.com (Postfix) with ESMTPA id 4BB3D60009;
        Fri, 17 Jun 2022 19:06:05 +0000 (UTC)
Message-ID: <5c7f67b13037d5c95318f3de6f4f34f01c4aca10.camel@perches.com>
Subject: Re: [PATCH 2/2] Documentation: Add a blurb about using
 scripts/git-send-email.sh
From:   Joe Perches <joe@perches.com>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Date:   Fri, 17 Jun 2022 12:06:04 -0700
In-Reply-To: <MN0PR12MB6101040D61CBD6E0E1B588E9E2AF9@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20220617183215.25917-1-mario.limonciello@amd.com>
         <20220617183215.25917-2-mario.limonciello@amd.com>
         <87ilozp1j7.fsf@meer.lwn.net>
         <MN0PR12MB6101040D61CBD6E0E1B588E9E2AF9@MN0PR12MB6101.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Stat-Signature: 1sxstrsbxmgbncuca8cxa8o7akhzkcaz
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 4BB3D60009
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18sHghYu7OldyvKKPjzDppsiAUK31joTb0=
X-HE-Tag: 1655492765-797362
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-06-17 at 18:54 +0000, Limonciello, Mario wrote:
> > -----Original Message-----
> > From: Jonathan Corbet <corbet@lwn.net>
[]
> > > diff --git a/Documentation/process/submitting-patches.rst
[]
> > > @@ -225,7 +225,10 @@ Select the recipients for your patch
> > >  ------------------------------------
> > > 
> > >  You should always copy the appropriate subsystem maintainer(s) on any patch
> > > -to code that they maintain; look through the MAINTAINERS file and the
> > > +to code that they maintain. A helper script is available in
> > > +./scripts/git-send-email.sh that can be used with git-send-email to automatically
> > > +findd the appropriate recipients for a patch.
> > 
> > Please run a spelling checker on your documentation changes.
> Oh whoops; sorry.  I'm a bit surprised ./scripts/checkpatch didn't catch that.

checkpatch (and codespell) relies on a list of common misspellings.

You could add the misspelling to scripts/spelling.txt or maybe
add --codespell to the checkpatch invocation.

But adding --codespell here didn't find that typo either as
the codespell dictionary list doesn't include "findd".

