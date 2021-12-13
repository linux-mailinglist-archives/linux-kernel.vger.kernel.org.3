Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44183473132
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 17:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234625AbhLMQFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 11:05:00 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:57886 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233834AbhLMQE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 11:04:59 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:34376)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mwnou-006wj5-2j; Mon, 13 Dec 2021 09:04:56 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:41406 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mwnos-00BNJ8-Ns; Mon, 13 Dec 2021 09:04:55 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        keescook@chromium.org, jlayton@kernel.org, bfields@fieldses.org,
        yzaikin@google.com, wangle6@huawei.com,
        Joe Perches <joe@perches.com>
References: <20211207011320.100102-1-nixiaoming@huawei.com>
        <20211206173842.72c76379adbf8005bfa66e26@linux-foundation.org>
        <Ya/BnndSXKHiUpGm@bombadil.infradead.org>
        <875ys0azt8.fsf@email.froward.int.ebiederm.org>
        <Ya/iv33Ud+KRt9E9@bombadil.infradead.org>
Date:   Mon, 13 Dec 2021 10:04:48 -0600
In-Reply-To: <Ya/iv33Ud+KRt9E9@bombadil.infradead.org> (Luis Chamberlain's
        message of "Tue, 7 Dec 2021 14:39:59 -0800")
Message-ID: <87mtl4ze1r.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mwnos-00BNJ8-Ns;;;mid=<87mtl4ze1r.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+G1dffwNItkTA2Apl2BbqBPtVXL5fVmSo=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4801]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Luis Chamberlain <mcgrof@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 755 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 14 (1.9%), b_tie_ro: 12 (1.6%), parse: 1.73
        (0.2%), extract_message_metadata: 23 (3.1%), get_uri_detail_list: 3.9
        (0.5%), tests_pri_-1000: 4.9 (0.6%), tests_pri_-950: 1.35 (0.2%),
        tests_pri_-900: 1.25 (0.2%), tests_pri_-90: 188 (24.9%), check_bayes:
        184 (24.4%), b_tokenize: 11 (1.5%), b_tok_get_all: 13 (1.7%),
        b_comp_prob: 5 (0.7%), b_tok_touch_all: 148 (19.6%), b_finish: 1.42
        (0.2%), tests_pri_0: 504 (66.7%), check_dkim_signature: 0.56 (0.1%),
        check_dkim_adsp: 2.8 (0.4%), poll_dns_idle: 0.63 (0.1%), tests_pri_10:
        2.4 (0.3%), tests_pri_500: 9 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] sysctl: Add a group of macro functions to initcall the sysctl table of each feature
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Luis Chamberlain <mcgrof@kernel.org> writes:

> On Tue, Dec 07, 2021 at 03:08:03PM -0600, Eric W. Biederman wrote:
>> Luis Chamberlain <mcgrof@kernel.org> writes:
>> 
>> > On Mon, Dec 06, 2021 at 05:38:42PM -0800, Andrew Morton wrote:
>> >> On Tue, 7 Dec 2021 09:13:20 +0800 Xiaoming Ni <nixiaoming@huawei.com> wrote:
>> >> > --- a/fs/inode.c
>> >> > +++ b/fs/inode.c
>> >> > @@ -132,12 +132,7 @@ static struct ctl_table inodes_sysctls[] = {
>> >> >  	{ }
>> >> >  };
>> >> >  
>> >> > -static int __init init_fs_inode_sysctls(void)
>> >> > -{
>> >> > -	register_sysctl_init("fs", inodes_sysctls);
>> >> > -	return 0;
>> >> > -}
>> >> > -early_initcall(init_fs_inode_sysctls);
>> >> > +fs_sysctl_initcall(inodes_sysctls);
>> >> >  #endif
>> >> 
>> >> Here's another, of many.
>> >> 
>> >> Someone made the decision to use early_initcall() here (why?) and this
>> >> patch switches it to late_initcall()!  Worrisome.  Each such stealth
>> >> conversion should be explained and justified, shouldn't it?
>> >
>> > I made the decisions for quite a bit of the ordering and yes I agree
>> > this need *very careful* explanation, specially if we are going to
>> > generalize this.
>> >
>> > First and foremost. git grep for sysctl_init_bases and you will see
>> > that the bases for now are initialized on proc_sys_init() and that
>> > gets called on proc_root_init() and that in turn on init/main.c's
>> > start_kernel(). And so this happens *before* the init levels.
>> >
>> > The proper care for what goes on top of this needs to take into
>> > consideration the different init levels and that the if a sysctl
>> > is using a directory *on top* of a base, then that sysctl registration
>> > must be registered *after* that directory. The *base* directory for
>> > "fs" is now registered through fs/sysctls.c() on init_fs_sysctls()
>> > using register_sysctl_base(). I made these changes with these names
>> > and requiring the DECLARE_SYSCTL_BASE() so it would be easy for us
>> > to look at where these are declared.
>> >
>> > So the next step in order to consider is *link* ordering and that
>> > order is maintained by the Makefile. That is why I put this at the
>> > top of the fs Makfile:
>> >
>> > obj-$(CONFIG_SYSCTL)            += sysctls.o 
>> >
>> > So any file after this can use early_initcall(), because the base
>> > for "fs" was declared first in link order, and it used early_initcall().
>> > It is fine to have the other stuff that goes on top of the "fs" base
>> > use late_initcall() but that assumes that vetting has been done so that
>> > if a directory on "fs" was created, let's call it "foo", vetting was done
>> > to ensure that things on top of "foo" are registered *after* the "foo"
>> > directory.
>> >
>> > We now have done the cleanup for "fs", and we can do what we see fine
>> > for "fs", but we may run into surprises later with the other bases, so
>> > I'd be wary of making assumptions at this point if we can use
>> > late_initcall().
>> >
>> > So, as a rule of thumb I'd like to see bases use early_initcall(). The
>> > rest requires manual work and vetting.
>> >
>> > So, how about this, we define fs_sysctl_initcall() to use also
>> > early_initcall(), and ask susbsystems to do their vetting so that
>> > the base also gets linked first.
>> >
>> > After this, if a directory on top of a base is created we should likely create
>> > a new init level and just bump that to use the next init level. So
>> > something like fs_sysctl_base_initcall_subdir_1() map to core_initcall()
>> > and so on.
>> >
>> > That would allow us to easily grep for directory structures easily and
>> > puts some implicit onus of ordering on those folks doing these conversions.
>> > We'd document well the link order stuff for those using the base stuff
>> > too as that is likely only where this will matter most.
>> 
>> I am a bit confused at this explanation of things.
>> 
>> Last I looked the implementation of sysctls allocated the directories
>> independently of the sysctls entries that populated them.
>
> With most sysctls being created using the same kernel/sysctl.c file and
> structure, yes, this was true. With the changes now on linux-next things
> change a bit. The goal is to move sysctls to be registered where they
> are actually defined. But the directory that holds them must be
> registered first.

Why?

If you look at __register_sysctl_table the core registration function
you will see that all directory entries get reduced to simply a path
component.  So they have nothing but their names as input into
the sysctl subsystem.

Further __register_sysctl_table goes in a loop through the path
and does get_subdir to find or create the directory.

Which means that if two places were to register sysctls in
the "fs" directory they would both use the safe "fs" directory
and whoever can first would create it.

Which should mean that worrying about ordering is completely
unnecessary.

What am I missing?


> During the first phase of cleanups now on linux-next
> all filesystem "fs" syscls were moved to be delcared in the kernel's
> fs/ directory. The last part was to register the base "fs" directory.
> For this declareres were added to simplify that and to clarify which
> are base directories:

Unless you are have something playing games with the ctl_table_set
that is all unnecessary.

>
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=ededd3fc701668743087c77ceeeb7490107cc12c
>
> Then, this commit moves the "fs" base to be declared to fs/ as well:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=d0f885a73ec6e05803ce99f279232b3116061ed8
>
> This used early_initcall() for the base for "fs" and that is
> because there are no built-in sysctls for "fs" which need to
> be exposed prior to the init levels.
>
> So after this then order is important. If you are using the same
> init level, the the next thing which will ensure order is the order
> of things being linked, so what order they appear on the Makefile.
> And this is why the base move for the "fs" sysctl directory is kept
> at the top of fs/Makfile:

I really think this is doing a lot of work to ensure ordering that
is not necessary.   I did not see anything in your patches that adds
an ordering requirement.

I don't see anything in the existing code that adds an ordering
requirement.

Eric
