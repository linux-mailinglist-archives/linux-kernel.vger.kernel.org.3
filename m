Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA0D4F4EA9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1836097AbiDFAex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387898AbiDENTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 09:19:52 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BAF132E93
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 05:22:52 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id q19so12112527wrc.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 05:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BSIy0g7O0TqZGI4rDC2/vNxWHM1FlM+amJEfAapz9p0=;
        b=WpZRbe3UyQYhQbG0hzp8tnTAJdBVI0cfmNcHmSUz9S2yZ+ttusx9AYYJQVuSP1/J6j
         wTO6trpwENcBdfRI8LDgdsNAKAohDDJ7SbjH1y04VtNFBWFsS3u+H2MJKYmaeBHacwKk
         1rD92lPr1lmfdC91KO5a6h5yMQKXyI+bQFHTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BSIy0g7O0TqZGI4rDC2/vNxWHM1FlM+amJEfAapz9p0=;
        b=Zqkey2reVxszlrcn+exsQk8qXMBw7zh88yT9JGZoW5WWRykb60p1U0tM8CK1aM90KF
         B5JARicNd1wDW6YHITNJkyT3HSwr2N7wL9N9VyGJYyhycRGdBYGcBAYOanTAT/JLTW6i
         EzsxmjAa38sSJSPGo91sHJum7KpQFAw0Sr/WSE9mYh2XaixwvxOn7wkdxBx7JiirJaVa
         Tst7Bzu1psZ361aB6aoORkdlGgmgQVt6YVBY5JTUI/XjxWxHeWbWGXtlRAv2JdS/GCE0
         wPPcz0JidOOlsMAo8iVfWN19LYlhgP54jQLhno8/AjIPD2d60497Li5mkXaraPZg6QvB
         cLqQ==
X-Gm-Message-State: AOAM532J4ZKTWxHo5ifAaqK5rYwsm5+NKXQR6ilnyyeK5IqG45LlVK8P
        MGD1FYESQN66v4AUtICJckezWyW6SlMf7Czz
X-Google-Smtp-Source: ABdhPJyqEGFGD3PY2N1e2WmZawTx5CNDo3uBZfWyAjRwwIIOeYMTN5xqY37/aKrdiPfusdW5/H4zEA==
X-Received: by 2002:a5d:6c65:0:b0:204:119d:37e2 with SMTP id r5-20020a5d6c65000000b00204119d37e2mr2470594wrz.635.1649161370760;
        Tue, 05 Apr 2022 05:22:50 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::4:2e47])
        by smtp.gmail.com with ESMTPSA id n8-20020a7bcbc8000000b0038ca55f9bcasm1952463wmi.42.2022.04.05.05.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 05:22:50 -0700 (PDT)
Date:   Tue, 5 Apr 2022 13:22:49 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk/index: Printk index feature documentation
Message-ID: <Ykw0mdX0GXZWJohH@chrisdown.name>
References: <20220405114829.31837-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220405114829.31837-1-pmladek@suse.com>
User-Agent: Mutt/2.2.2 (aa28abe8) (2022-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Mladek writes:
>Document the printk index feature. The primary motivation is to
>explain that it is not creating KABI from particular printk() calls.
>
>Signed-off-by: Petr Mladek <pmladek@suse.com>
>Acked-by: Sergey Senozhatsky <senozhatsky@chromium.org>

This looks great, thanks a lot for spending the time to write this up. Just 
some very minor comments.

Reviewed-by: Chris Down <chris@chrisdown.name>

>---
>Changes against RFC[*]:
>
>  + Updated text by feedback from Darrick.
>  + Updated index.rst and MAINTAINERS.
>  + Tested build of the html documentation.
>
>Did not add Sergey's ack because there were some changes.
>
>[*] https://lore.kernel.org/r/20220330145955.GB4384@pathway.suse.cz
>
> Documentation/core-api/index.rst        |   1 +
> Documentation/core-api/printk-index.rst | 136 ++++++++++++++++++++++++
> MAINTAINERS                             |   1 +
> 3 files changed, 138 insertions(+)
> create mode 100644 Documentation/core-api/printk-index.rst
>
>diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
>index 972d46a5ddf6..8a3fce1fe582 100644
>--- a/Documentation/core-api/index.rst
>+++ b/Documentation/core-api/index.rst
>@@ -20,6 +20,7 @@ it.
>    workqueue
>    printk-basics
>    printk-formats
>+   printk-index
>    symbol-namespaces
>
> Data structures and low-level utilities
>diff --git a/Documentation/core-api/printk-index.rst b/Documentation/core-api/printk-index.rst
>new file mode 100644
>index 000000000000..0de380b4a67c
>--- /dev/null
>+++ b/Documentation/core-api/printk-index.rst
>@@ -0,0 +1,136 @@
>+.. SPDX-License-Identifier: GPL-2.0
>+
>+============
>+Printk Index
>+============
>+
>+There are many ways how to monitor the state of the system. One important
>+source of information is the system log. It provides a lot of information,
>+including more or less important warnings and error messages.
>+
>+There are monitoring tools that filter and take action based on messages
>+logged.
>+
>+The kernel messages are evolving together with the code. As a result,
>+particular kernel messages are not KABI and never will be!
>+
>+It is a huge challenge for maintaining the system log monitors. It requires
>+knowing what messages were updated in a particular kernel version and why.
>+Finding these changes in the sources would require non-trivial parsers.
>+Also it would require matching the sources with the binary kernel which
>+is not always trivial. Various changes might be backported. Various kernel
>+versions might be used on different monitored systems.
>+
>+This is where the printk index feature might become useful. It provides
>+a dump of printk formats used all over the source code used for the kernel
>+and modules on the running system. It is accessible at runtime via debugfs.
>+
>+The printk index helps to find changes in the message formats. Also it helps
>+to track the strings back to the kernel sources and the related commit.
>+
>+
>+User Interface
>+==============
>+
>+The index of printk formats are split in into separate files. The files are
>+named according to the binaries where the printk formats are built-in. There
>+is always "vmlinux" and optionally also modules, for example::
>+
>+   /sys/kernel/debug/printk/index/vmlinux
>+   /sys/kernel/debug/printk/index/ext4
>+   /sys/kernel/debug/printk/index/scsi_mod
>+
>+Note that only loaded modules are shown. Also printk formats from a module
>+might appear in "vmlinux" when the module is built-in.
>+
>+The content is inspired by the dynamic debug interface and looks like::

s/::/:/

>+
>+   $> head -1 /sys/kernel/debug/printk/index/vmlinux; shuf -n 5 vmlinux
>+   # <level[,flags]> filename:line function "format"
>+   <5> block/blk-settings.c:661 disk_stack_limits "%s: Warning: Device %s is misaligned\n"
>+   <4> kernel/trace/trace.c:8296 trace_create_file "Could not create tracefs '%s' entry\n"
>+   <6> arch/x86/kernel/hpet.c:144 _hpet_print_config "hpet: %s(%d):\n"
>+   <6> init/do_mounts.c:605 prepare_namespace "Waiting for root device %s...\n"
>+   <6> drivers/acpi/osl.c:1410 acpi_no_auto_serialize_setup "ACPI: auto-serialization disabled\n"
>+
>+, where the meaning is::
>+
>+   - level: log level

Maybe worth noting that level may not be there if we have a KERN_CONT.

>+   - flags: optional flags: currently only 'c' for KERN_CONT
>+   - filename:line: source filename and line number of the related
>+	printk() call. Note that there are many wrappers, for example,
>+	pr_warn(), pr_warn_once(), dev_warn().
>+   - function: function name where the printk() call is used.
>+   - format: format string
>+
>+The extra information makes it a bit harder to find differences
>+between various kernels. Especially the line number might change
>+very often. On the other hand, it helps a lot to confirm that
>+it is the same string or find the commit that is responsible
>+for eventual changes.
>+
>+
>+printk() Is Not a Stable KABI
>+=============================
>+
>+Several developers are afraid that exporting all these implementation
>+details into the user space will transform particular printk() calls
>+into KABI.
>+
>+But it is exactly the opposite. printk() calls must _not_ be KABI.
>+And the printk index helps user space tools to deal with this.
>+
>+
>+Subsystem specific printk wrappers
>+==================================
>+
>+The printk index is generated using extra metadata that are stored in
>+a dedicated .elf section ".printk_index". It is achieved using macro
>+wrappers doing __printk_index_emit() together with the real printk()
>+call. The same technique is used also for the metadata used by
>+the dynamic debug feature.
>+
>+The metadata are stored for a particular message only when it is printed
>+using these special wrappers. It is implemented for the commonly
>+used printk() calls, including, for example, pr_warn(), or pr_once().
>+
>+Additional changes are necessary for various subsystem specific wrappers
>+that call the original printk() via a common helper function. These needs
>+their own wrappers adding __printk_index_emit().
>+
>+Only few subsystem specific wrappers have been updated so far,
>+for example, dev_printk(). As a result, the printk formats from
>+some subsystes can be missing in the printk index.
>+
>+
>+Subsystem specific prefix
>+=========================
>+
>+The macro pr_fmt() macro allows to define a prefix that is printed
>+before the string generated by the related printk() calls.
>+
>+Subsystem specific wrappers usually add even more complicated
>+prefixes.
>+
>+These prefixes can be stored into the printk index metadata
>+by an optional parameter of __printk_index_emit(). The debugfs
>+interface might then show the printk formats including these prefixes.
>+For example, drivers/acpi/osl.c contains::
>+
>+  #define pr_fmt(fmt) "ACPI: OSL: " fmt
>+
>+  static int __init acpi_no_auto_serialize_setup(char *str)
>+  {
>+	acpi_gbl_auto_serialize_methods = FALSE;
>+	pr_info("Auto-serialization disabled\n");
>+
>+	return 1;
>+  }
>+
>+This results in the following printk index entry::
>+
>+  <6> drivers/acpi/osl.c:1410 acpi_no_auto_serialize_setup "ACPI: auto-serialization disabled\n"
>+
>+It helps matching messages from the real log with printk index.
>+Then the source file name, line number, and function name can
>+be used to match the string with the source code.
>diff --git a/MAINTAINERS b/MAINTAINERS
>index fd768d43e048..ad8625130ea9 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -15855,6 +15855,7 @@ F:	kernel/printk/
> PRINTK INDEXING
> R:	Chris Down <chris@chrisdown.name>
> S:	Maintained
>+F:	Documentation/core-api/printk-index.rst
> F:	kernel/printk/index.c
>
> PROC FILESYSTEM
>-- 
>2.26.2
>
