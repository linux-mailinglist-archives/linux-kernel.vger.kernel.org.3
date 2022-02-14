Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14DD14B4318
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 08:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241516AbiBNHrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 02:47:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbiBNHrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 02:47:49 -0500
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332F55AED7;
        Sun, 13 Feb 2022 23:47:42 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 4022E580307;
        Mon, 14 Feb 2022 02:47:41 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 14 Feb 2022 02:47:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=hAXX3YSLYKv5f+3SJ
        iOjChLyf8mfaVkznY08o7XQW04=; b=AEFHuuBiG5Rx7IwbFz2PZNrjBSV+zjWCk
        INbNRR9KxljQlpP+7uStHn16q1SnXUgQf7tclU2wVvllgh5tuZZteV08hVSPAJqn
        9Dic8MUa/tISNShO0PY2vQlE6RBggjfTqJALeJk0HkyFi7qFfQm8fWpkfKFy2Iw4
        7awm3Y5s4ZdYB7d/0kAyKb3FzGmCRjb6eGaGimjxXR9AIa3uivhRSmaiugigOgeI
        KvjnXEfI5H/hDwTDfiKQC3unegasIQdS/CjSXcf5PR8Ls3BL+rKYUWurXiMxGLYG
        O7XdsbMSqUP4LJL/wHVQfxSqc0ou6NB5jo5ZSTvXYgzM1nCLOLKeA==
X-ME-Sender: <xms:GAkKYo-6CdMYwzh8ssqo1lS500yoCiLZOGwg1o_rB9fbb_uecxnVtA>
    <xme:GAkKYgsFi97jM0nScOUwioPd_y_TW45suu8GOYokal6312azFy6Mbjv-PhAQjj6zH
    D211jMdhq3umC8>
X-ME-Received: <xmr:GAkKYuBfPc-GAIVk99c2_Pwnu1OMfogOOt8ce0GqRiNJXcnoM-pMKzUqs4oGkDBRp7VIrgP2fAF9bQtDRwUgrQHIhG8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrjedugdduudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfu
    tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtth
    gvrhhnpefgvefgveeuudeuffeiffehieffgfejleevtdetueetueffkeevgffgtddugfek
    veenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:GAkKYod-qEiQCIdV_VZvmD-bunUy86Dfw0UqUWJRnHK4DV07pTOpkQ>
    <xmx:GAkKYtPtIkRxnipq1gT07lMIbcVsFr7qGcWlHCa5oTTH-p3MX-0zWw>
    <xmx:GAkKYilx9R30KFjPp136qCE2IlJnh8Xa8Oy3L58ihexHTPalDixoPA>
    <xmx:HQkKYvGitqYU94RhMQeTbk4UKrJg1g2I0w1F2J0fsk-EUyVkzI_D8A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Feb 2022 02:47:35 -0500 (EST)
Date:   Mon, 14 Feb 2022 09:47:32 +0200
From:   Ido Schimmel <idosch@idosch.org>
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     Domenico Andreoli <domenico.andreoli@linux.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        David Airlie <airlied@linux.ie>,
        Andrew Morton <akpm@linux-foundation.org>, amir73il@gmail.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, bcrl@kvack.org,
        benh@kernel.crashing.org, clemens@ladisch.de, crope@iki.fi,
        dgilbert@interlog.com, Greg KH <gregkh@linuxfoundation.org>,
        jack@suse.cz, jani.nikula@intel.com,
        Jani Nikula <jani.nikula@linux.intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>, jlbec@evilplan.org,
        john.ogness@linutronix.de,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>, julia.lawall@inria.fr,
        Kees Cook <keescook@chromium.org>, kernel@tuxforce.de,
        Linux Memory Management List <linux-mm@kvack.org>,
        Mark Fasheh <mark@fasheh.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        mm-commits@vger.kernel.org, nixiaoming@huawei.com,
        penguin-kernel@i-love.sakura.ne.jp, peterz@infradead.org,
        Phillip Potter <phil@philpotter.co.uk>,
        Paul Turner <pjt@google.com>, pmladek@suse.com,
        rafael@kernel.org, Rodrigo Vivi <rodrigo.vivi@intel.com>,
        rostedt@goodmis.org, senozhatsky@chromium.org, sre@kernel.org,
        steve@sk2.org, Suren Baghdasaryan <surenb@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>, tytso@mit.edu,
        Al Viro <viro@zeniv.linux.org.uk>, wangqing@vivo.com,
        Iurii Zaikin <yzaikin@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        regressions@lists.linux.dev
Subject: Re: [PATCH v2] Fix regression due to "fs: move binfmt_misc sysctl to
 its own file"
Message-ID: <YgoJFAltbyqTT6Kz@shredder>
References: <20220121221021.60533b009c357d660791476e@linux-foundation.org>
 <20220122061228.nmuo75sDn%akpm@linux-foundation.org>
 <YgEeQNdgBuHRyEWl@dumbo>
 <YgGTSR628xhRvCjB@bombadil.infradead.org>
 <CAA5qM4BGmrkwatyO_h3F=ErDZ9t5swuttbt6NkQU-1KDGDiD4g@mail.gmail.com>
 <YgKmaggsipzzCGCg@bombadil.infradead.org>
 <YgNyAC8VMeuOD/uQ@dumbo>
 <YgklDvNecca1/8in@shredder>
 <CAA5qM4AP=pOi1dFFgELJ97nSwTBqrruseGmTF-qab=xj2==_Xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA5qM4AP=pOi1dFFgELJ97nSwTBqrruseGmTF-qab=xj2==_Xg@mail.gmail.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 13, 2022 at 01:10:42PM -0800, Tong Zhang wrote:
> Hi Ido,
> Thanks for the report. This is a known issue. The fix is proposed here.
> https://lore.kernel.org/all/YgRbEG21AUrLSFKX@bombadil.infradead.org/

Great, thanks for letting me know
