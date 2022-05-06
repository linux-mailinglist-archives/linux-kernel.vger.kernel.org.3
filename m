Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58E051DE03
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 19:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444025AbiEFRDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 13:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444022AbiEFRDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 13:03:42 -0400
Received: from wrqvvpks.outbound-mail.sendgrid.net (wrqvvpks.outbound-mail.sendgrid.net [149.72.131.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205B16A40E
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 09:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=catern.com;
        h=from:subject:in-reply-to:references:mime-version:to:cc:content-type:
        content-transfer-encoding;
        s=s1; bh=0kv8Y+pw6sAthOMznHqH5eVjKXOt00qV9e4yFDnt+Es=;
        b=JyGuBIUDLSg4VXtCtO+PrvbRjlHlYCWKmbwjPwbfXPEBx5aN/PKoexTCq249YbDPbeWO
        PtA9yI37NUqajl8TtUDOxJPsJZPdoZc0f4BOyHJFEAs0+N9Tgzn7WSTF6w34GdGlRK3ob2
        5p/SWiyqSLmOjpS6RNmfIFjcrKAJPbAI5SKDW6vMnhbSFhV/CQEh9vYF+z8JcFodjYuKWY
        Y00pZ52/0HprIoV4nG7CtUVXPI8/E0+l+HHsNgm+dbPZspoWc6fj/dS8vHormThs86lRO9
        07IIi4OMbFj5tYdnOsI2sPYXUvofIHnKPSQZGiy7cDj541Uwh0WpDUk6w5w4AhyA==
Received: by filterdrecv-77df7bffc9-b2j5p with SMTP id filterdrecv-77df7bffc9-b2j5p-1-627553ED-5E
        2022-05-06 16:59:25.839025366 +0000 UTC m=+2574812.774299640
Received: from earth.catern.com (unknown)
        by geopod-ismtpd-2-2 (SG)
        with ESMTP
        id lPNwAp36QO6WuhyWBDuI8g
        Fri, 06 May 2022 16:59:25.688 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=::1; helo=localhost; envelope-from=sbaugh@catern.com; receiver=<UNKNOWN> 
Received: from localhost (localhost [IPv6:::1])
        by earth.catern.com (Postfix) with ESMTPSA id 966DA60040;
        Fri,  6 May 2022 12:59:24 -0400 (EDT)
From:   Spencer Baugh <sbaugh@catern.com>
Subject: Re: Explicitly defining the userspace API
In-Reply-To: <YmA/jFztk5GkjIr2@kroah.com>
References: <874k2nhgtg.fsf@catern.com> <YmA/jFztk5GkjIr2@kroah.com>
Date:   Fri, 06 May 2022 16:59:26 +0000 (UTC)
Message-ID: <87levefvgz.fsf@catern.com>
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?GW3oCMoYnalRiojMOuLzE6x2H5kORXvlCdz1UwQVRMVT4fbh9ODEfCogOe74cO?=
 =?us-ascii?Q?rI4e0V+MFZgakz9Re5a6=2FCgloGF35IKSfipc2eg?=
 =?us-ascii?Q?gco3jvfFNeZBoapduVGgMA+K=2F4SfxXcosVfTDgq?=
 =?us-ascii?Q?NVbZkA6JzG4eHrV1fet9KMsG2zjt1m1jpbhM4+s?=
 =?us-ascii?Q?j0szgyOzQfAJPXrmqWpxOgRDAsoCI0TRPkt2yvN?=
 =?us-ascii?Q?jgLmkm7A9=2FPAh1t2R0K3L1PRg9Og=2Ff0bU5gZHM?=
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        marcin@juszkiewicz.com.pl, torvalds@linux-foundation.org,
        arnd@arndb.de
X-Entity-ID: d/0VcHixlS0t7iB1YKCv4Q==
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@linuxfoundation.org> writes:
> On Wed, Apr 20, 2022 at 04:15:25PM +0000, Spencer Baugh wrote:
>> 
>> Linux guarantees the stability of its userspace API, but the API
>> itself is only informally described, primarily with English prose.  I
>> want to add an explicit, authoritative machine-readable definition of
>> the Linux userspace API.
>> 
>> As background, in a conventional libc like glibc, read(2) calls the
>> Linux system call read, passing arguments in an architecture-specific
>> way according to the specific details of read.
>> 
>> The details of these syscalls are at best documented in manpages, and
>> often defined only by the implementation.  Anyone else who wants to
>> work with a syscall, in any way, needs to duplicate all those details.
>> 
>> So the most basic definition of the API would just represent the
>> information already present in SYSCALL_DEFINE macros: the C types of
>> arguments and return values.  More usefully, it would describe the
>> formats of those arguments and return values: that the first argument
>> to read is a file descriptor rather than an arbitrary integer, and
>> what flags are valid in the flags argument of openat, and that open
>> returns a file descriptor.  A step beyond that would be describing, in
>> some limited way, the effects of syscalls; for example, that read
>> writes into the passed buffer the number of bytes that it returned.
>
> So how would you define read() in this format in a way that has not
> already been attempted in the past?

I don't know about any attempts at doing this in the past (other than
what's already been mentioned in this thread - e.g. SYSCALL_DEFINE),
what do you have in mind?

> How are you going to define a format that explains functionality in a
> way that is not just the implementation in the end?

Lots of information can be expressed just with more specific types on
the function signature, even with regular C types.  No need to expose
the implementation in any way.

For example, accept4's signature is:

SYSCALL_DEFINE4(accept4, int, fd, struct sockaddr __user *, upeer_sockaddr,
		int __user *, upeer_addrlen, int, flags)

Here, fd and flags are the same type and have nothing to distinguish
them.  But, purely as an example, not suggesting exactly this, but one
could have:

typedef int user_fd_t;
typedef int accept_flags_t;

SYSCALL_DEFINE4(accept4, user_fd_t, fd, struct sockaddr __user *, upeer_sockaddr,
		int __user *, upeer_addrlen, accept_flags_t, flags)

Then a user could parse this SYSCALL_DEFINE and know that fd and flags
have different types with different possible valid values. user_fd_t
would be used by many different syscalls, accept_flags_t just by this.

With just this, the user of this information would still need to know
what user_fd and accept_flags are.  The next step would be describing
the valid values for accept_flags.  Unfortunately that's not something
that the C type system alone can express, but again purely as an
example, but one could have something like:

FLAGS_DEFINE(accept_flags, int,
  SOCK_CLOEXEC,
  SOCK_NONBLOCK)

Then a user could parse this FLAGS_DEFINE and know what the range of
valid values for accept_flags_t is.  This could also be used in the
kernel; for example, FLAGS_DEFINE could generate an accept_flags_valid
function, usable in accept4 as:

if (!accept_flags_valid(flags))
	return -EINVAL;

As for describing the buffer-writing behavior of read like I mentioned
before, here's a sketch of what that maybe could look like.  The current
signature of read is:

SYSCALL_DEFINE3(read, unsigned int, fd, char __user *, buf, size_t, count)

One could imagine adding a type to the return value and changing this to
something like:

#define bytes_written_or_error(written_buffer) int
#define writable_user_buf(size_of_buffer) char __user *

SYSCALL_DEFINE3_RET(bytes_written_or_error(buf),
                    read, unsigned int, fd,
                    writable_user_buf(count), buf, size_t, count)

A user could parse this and know at least partially how read uses the
passed-in buffer, without having to look at the implementation.

Just for the sake of mentioning it, one could also imagine static
analysis which checks the kernel implementation against these
more-detailed types, which could catch bugs.  But I'm not necessarily
proposing doing that - this is useful on its own even if it's not
checked by static analysis.

>> One step in this direction is Documentation/ABI, which specifies the
>> stability guarantees for different userspace APIs in a semi-formal
>> way.  But it doesn't specify the actual content of those APIs, and it
>> doesn't cover individual syscalls at all.
>
> The content is described in Documentation/ABI/ entries, where do you see
> that missing?

I meant that it doesn't describe the content of the APIs in a
machine-readable way.  (It's still very useful of course!)

> And you are correct, that place does not describe syscalls, or other
> user/kernel interfaces that predate sysfs.
>
> good luck!

Thank you!
