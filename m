Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1450A4F13F9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 13:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358263AbiDDLrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 07:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244573AbiDDLrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 07:47:20 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF9A329A8;
        Mon,  4 Apr 2022 04:45:23 -0700 (PDT)
Received: from mail-wr1-f49.google.com ([209.85.221.49]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MsHwC-1npyLw0OpG-00tlaA; Mon, 04 Apr 2022 13:45:22 +0200
Received: by mail-wr1-f49.google.com with SMTP id c7so14191153wrd.0;
        Mon, 04 Apr 2022 04:45:22 -0700 (PDT)
X-Gm-Message-State: AOAM532Sn/JHcFkOaPnFHE0oak9sehSBRI1GW1dseXYDu+b0YWAJOkJN
        zUx9mEqekUiL8SiEMmWGkv1sKyn2PUL4/yC+S+4=
X-Google-Smtp-Source: ABdhPJwhgSzcGW7mYY0ePdwcl2vcqy6aJ6A3H/O9FiIOdk8/1Zn0n+iZ5A6GVOuTZXLLHkHSiOUewXtL8tv8S8t3u1Q=
X-Received: by 2002:adf:d081:0:b0:1ef:9378:b7cc with SMTP id
 y1-20020adfd081000000b001ef9378b7ccmr17218185wrh.407.1649072721694; Mon, 04
 Apr 2022 04:45:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wg6FWL1xjVyHx7DdjD2dHZETA5_=FqqW17Z19X-WTfWSg@mail.gmail.com>
 <20220404074734.1092959-1-geert@linux-m68k.org> <alpine.DEB.2.22.394.2204041006230.1941618@ramsan.of.borg>
 <20220404092655.GR1544202@dread.disaster.area> <CAMuHMdWgqdR1o3wT9pjB=w8z=2xaDFv5DJX58-HPHOFRm3Tr8Q@mail.gmail.com>
In-Reply-To: <CAMuHMdWgqdR1o3wT9pjB=w8z=2xaDFv5DJX58-HPHOFRm3Tr8Q@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 4 Apr 2022 13:45:05 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0QrihBR_2FQ7uZ5w2JmLjv7czfrrarCMmJOhvNdJ3p9g@mail.gmail.com>
Message-ID: <CAK8P3a0QrihBR_2FQ7uZ5w2JmLjv7czfrrarCMmJOhvNdJ3p9g@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.18-rc1
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:+huY3hK2urJ9qq03L1i/LmriJ4aMonG077tYui7AJOV52WqdA9E
 i26ULUV6PZpHU5oi+1d+gMQJNJJn3DyamjcrxzjpHK0jFNCbz/fU1rNvBOQTogZGP91ZI2n
 vJ1B2oXXY13LGldUsNIjBq4lVrOEunncF5rGVewv7y3c84IGRCg5HHZTVREX5siDR+7I3fx
 egLuOjY64bxud+12hUiuQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MaZ6sMkZkVE=:BaWZ7NDEy9rUxjEeSOTwt8
 2xV4gQjtuIJJvmlZFRS97rs1RJPrsqVivuJhOi6QeVtSmi/5pKROYyWvYDuCUajWgnz0HMlqI
 aoRZRgOuwH/vTd9AhRhz7JL0K6uAkWZPgF943vHr70hPQCUR/gW9oIaohzLvoClXWEOSJ8nDu
 jvFmNP/58o42xNvplHLrVL0qZIQdC4gB81ULe0V8pedXCIVpsth0IXzDTGgKa+Io/2aU6Oaoi
 9R6ym6pPJxd90GIons+fcIIFmzjVPVyQjwr/Cktwmh/gfpxTFYLOHO8qwiTf4g09gw9AqpNWO
 K7zbwRlpG3vroETi/oaugAvzbgnwtBFw6dmvK0SEe4vuS9gUI59giq8eonUEkmUOvv9iEUlwQ
 xJIsx03n0lZjkR0xbt02NdacIhMi0q18t9h5Zis4xSvIJGttgWbfhDND/QqVOBxAmCKOnIVJb
 wK+6REL0DYwVwbjwMK/MXU5gRv8KoeLrPRL5Ollc9ekkMHpU1nmTVCm6ASmzBPrNx+ECuk8Nd
 KqkX3guzjwqTdTN4uE+zEDqdbKvfTXu8B+zKaYv42SUfMm/zPJ+mlIDNXrV1YJywqicRxCqK4
 ZfZsm7kOM3ZvzFkMKZOjbQ7/8vFbhmaOAgk/UR57SDKZ+HdBvrGSdPTZuJTZDomYYIVyBT8f+
 ggjSSVDg8gqtr74CfL5eU0KGqauEBRNRZ2r4/9ybN235VsAQDvCvBLhtXhGk5N71MtTk=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 4, 2022 at 12:19 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> >
> > /kisskb/src/fs/xfs/./xfs_trace.h:432:2: note: in expansion of macro 'TP_printk'
> >   TP_printk("dev %d:%d daddr 0x%llx bbcount 0x%x hold %d pincount %d "
> >   ^
> > /kisskb/src/fs/xfs/./xfs_trace.h:440:5: note: in expansion of macro '__print_flags'
> >      __print_flags(__entry->flags, "|", XFS_BUF_FLAGS),
> >      ^
> > /kisskb/src/fs/xfs/xfs_buf.h:67:4: note: in expansion of macro 'XBF_UNMAPPED'
> >   { XBF_UNMAPPED,  "UNMAPPED" }
> >     ^
> > /kisskb/src/fs/xfs/./xfs_trace.h:440:40: note: in expansion of macro 'XFS_BUF_FLAGS'
> >      __print_flags(__entry->flags, "|", XFS_BUF_FLAGS),
> >                                         ^
> > /kisskb/src/fs/xfs/./xfs_trace.h: In function 'trace_raw_output_xfs_buf_flags_class':
> > /kisskb/src/fs/xfs/xfs_buf.h:46:23: error: initializer element is not constant
> >  #define XBF_UNMAPPED  (1 << 31)/* do not map the buffer */
> >
> > This doesn't make a whole lotta sense to me. It's blown up in a
> > tracepoint macro in XFS that was not changed at all in 5.18-rc1, nor
> > was any of the surrounding XFS code or contexts.  Perhaps something
> > outside XFS changed to cause this on these platforms?
>
> Upon closer look, all builds showing this issue are using gcc-5...
>
> > Can you bisect this, please?
>
> Fortunately I still have gcc-5 installed on an older machine,
> and I could reproduce the issue on amd64 with
> "make allmodconfig fs/xfs/xfs_trace.o".
>
> Bisection points to commit e8c07082a810fbb9 ("Kbuild: move to
> -std=gnu11").
>
> [1] gcc version 5.5.0 20171010 (Ubuntu 5.5.0-12ubuntu1

Thanks for the report. I've produced it and can see that the problem
is assigning
the value of "(1 << 31)" to an 'unsigned long' struct member. Since this is
a signed integer overflow, the result is technically undefined behavior,
which gcc-5 does not accept as an integer constant.

The patch below fixes it for me, but I have not checked if there are any
other instances. This could also be done using the 'BIT()' macro if the
XFS maintainers prefer:

diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
index edcb6254fa6a..762348973e8c 100644
--- a/fs/xfs/xfs_buf.h
+++ b/fs/xfs/xfs_buf.h
@@ -22,28 +22,28 @@ struct xfs_buf;

 #define XFS_BUF_DADDR_NULL     ((xfs_daddr_t) (-1LL))

-#define XBF_READ        (1 << 0) /* buffer intended for reading from device */
-#define XBF_WRITE       (1 << 1) /* buffer intended for writing to device */
-#define XBF_READ_AHEAD  (1 << 2) /* asynchronous read-ahead */
-#define XBF_NO_IOACCT   (1 << 3) /* bypass I/O accounting (non-LRU bufs) */
-#define XBF_ASYNC       (1 << 4) /* initiator will not wait for completion */
-#define XBF_DONE        (1 << 5) /* all pages in the buffer uptodate */
-#define XBF_STALE       (1 << 6) /* buffer has been staled, do not find it */
-#define XBF_WRITE_FAIL  (1 << 7) /* async writes have failed on this buffer */
+#define XBF_READ        (1ul << 0) /* buffer intended for reading
from device */
+#define XBF_WRITE       (1ul << 1) /* buffer intended for writing to device */
+#define XBF_READ_AHEAD  (1ul << 2) /* asynchronous read-ahead */
+#define XBF_NO_IOACCT   (1ul << 3) /* bypass I/O accounting (non-LRU bufs) */
+#define XBF_ASYNC       (1ul << 4) /* initiator will not wait for completion */
+#define XBF_DONE        (1ul << 5) /* all pages in the buffer uptodate */
+#define XBF_STALE       (1ul << 6) /* buffer has been staled, do not find it */
+#define XBF_WRITE_FAIL  (1ul << 7) /* async writes have failed on
this buffer */

 /* buffer type flags for write callbacks */
-#define _XBF_INODES     (1 << 16)/* inode buffer */
-#define _XBF_DQUOTS     (1 << 17)/* dquot buffer */
-#define _XBF_LOGRECOVERY        (1 << 18)/* log recovery buffer */
+#define _XBF_INODES     (1ul << 16)/* inode buffer */
+#define _XBF_DQUOTS     (1ul << 17)/* dquot buffer */
+#define _XBF_LOGRECOVERY        (1ul << 18)/* log recovery buffer */

 /* flags used only internally */
-#define _XBF_PAGES      (1 << 20)/* backed by refcounted pages */
-#define _XBF_KMEM       (1 << 21)/* backed by heap memory */
-#define _XBF_DELWRI_Q   (1 << 22)/* buffer on a delwri queue */
+#define _XBF_PAGES      (1ul << 20)/* backed by refcounted pages */
+#define _XBF_KMEM       (1ul << 21)/* backed by heap memory */
+#define _XBF_DELWRI_Q   (1ul << 22)/* buffer on a delwri queue */

 /* flags used only as arguments to access routines */
-#define XBF_TRYLOCK     (1 << 30)/* lock requested, but do not wait */
-#define XBF_UNMAPPED    (1 << 31)/* do not map the buffer */
+#define XBF_TRYLOCK     (1ul << 30)/* lock requested, but do not wait */
+#define XBF_UNMAPPED    (1ul << 31)/* do not map the buffer */

 typedef unsigned int xfs_buf_flags_t;
