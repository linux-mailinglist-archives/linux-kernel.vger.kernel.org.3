Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071684ECE8A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 23:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351107AbiC3UtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 16:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbiC3UtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 16:49:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D421B3702E;
        Wed, 30 Mar 2022 13:47:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 706B061660;
        Wed, 30 Mar 2022 20:47:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACDD0C340EC;
        Wed, 30 Mar 2022 20:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648673236;
        bh=pa+8iq8ZJoICprFk7sv8v1hOZjtIozOopb4VPV5hSfY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SmEZs74pQW0rmNEZuGxXza5ipzijETzzBVKjs0UnX8Pocc2WrL36IQCtX1JBikQGS
         P0Otl6g+kDkcYWyzZrsa+mXoUb+42/lKWdB7BPKVCW47UYdAqSwOpGp0QoQyXMXh3O
         qxrZ17GYmY6RgRUDjz7t9pDH2Cd3lyzIW7OMNFhe3jKjyzwLMJaUDRTAXP4dM9JHF+
         OhIFD6kGoJlrwckmMzAIIaY+c748RfDneNQIeDfczrydaKs5Gagd7/cJH8Dvy5fdaj
         6NW+4Xbh8oSvqPv2PX1S1/RsJWrk0fmE7eB+0vN0TkzK+v8SxtTv6ulQm6aYfioosk
         FQ3s+hBYCpxfA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AFDD040407; Wed, 30 Mar 2022 17:47:13 -0300 (-03)
Date:   Wed, 30 Mar 2022 17:47:13 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Tanu M <tanu235m@gmail.com>
Cc:     linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, peterz@infradead.org
Subject: Re: [PATCH] perf tools/perf/python/tracepoint.py: Converted to
 Python3
Message-ID: <YkTB0ft2kVDk5yny@kernel.org>
References: <CAPS78prawYzRZnyhWjgOnGw4EwoswNwztvfZFdCOPOydFzVwzQ@mail.gmail.com>
 <YkS/6xjPDa/JevcQ@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YkS/6xjPDa/JevcQ@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 30, 2022 at 05:39:07PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Sun, Mar 27, 2022 at 11:08:46PM -0700, Tanu M escreveu:
> > Hi,
> > I have converted the tracepoint.py file to python3 as many of the
> > files in tools/perf are already written in python3.
> > 
> > Signed-off-by: Tanusree Debnath <tanu235m@gmail.com>
> 
> Got this:
> 
> ⬢[acme@toolbox perf]$ patch -p1 < ~/wb/1.patch
> patching file tools/perf/python/tracepoint.py
> patch: **** malformed patch at line 119: prev_state=0x%x ==> next_comm=%s next_pid=%d next_prio=%d" % (
> 
> ⬢[acme@toolbox perf]$
> 
> I'll apply it by hand, please check your e-mail client.

you forgot to add the author of that example to the Cc list, done, here
is how it ended up:

commit e2774e6d25c12478d43e47e5d268aee6441a8479
Author: Tanu M <tanu235m@gmail.com>
Date:   Sun Mar 27 23:08:46 2022 -0700

    perf python: Convert tracepoint.py example to python3
    
    Convert the tracepoint.py file to python3 as many of the files in
    tools/perf are already written in python3.
    
    Committer testing:
    
      # export PYTHONPATH=/tmp/build/perf/python/
      # python3 ~acme/git/perf/tools/perf/python/tracepoint.py | head
      time 67394457376909 prev_comm=swapper/12 prev_pid=0 prev_prio=120 prev_state=0x0 ==> next_comm=gnome-terminal- next_pid=3313 next_prio=120
      time 67394457807669 prev_comm=python3 prev_pid=1485930 prev_prio=120 prev_state=0x1 ==> next_comm=swapper/13 next_pid=0 next_prio=120
      time 67394457811859 prev_comm=swapper/13 prev_pid=0 prev_prio=120 prev_state=0x0 ==> next_comm=python3 next_pid=1485930 next_prio=120
      time 67394457824929 prev_comm=python3 prev_pid=1485930 prev_prio=120 prev_state=0x1 ==> next_comm=swapper/13 next_pid=0 next_prio=120
      time 67394457831899 prev_comm=swapper/13 prev_pid=0 prev_prio=120 prev_state=0x0 ==> next_comm=python3 next_pid=1485930 next_prio=120
      time 67394457842299 prev_comm=python3 prev_pid=1485930 prev_prio=120 prev_state=0x1 ==> next_comm=swapper/13 next_pid=0 next_prio=120
      time 67394457844179 prev_comm=swapper/13 prev_pid=0 prev_prio=120 prev_state=0x0 ==> next_comm=python3 next_pid=1485930 next_prio=120
      time 67394457853879 prev_comm=python3 prev_pid=1485930 prev_prio=120 prev_state=0x1 ==> next_comm=swapper/13 next_pid=0 next_prio=120
      time 67394457856339 prev_comm=swapper/13 prev_pid=0 prev_prio=120 prev_state=0x0 ==> next_comm=python3 next_pid=1485930 next_prio=120
      time 67394457865659 prev_comm=python3 prev_pid=1485930 prev_prio=120 prev_state=0x1 ==> next_comm=swapper/13 next_pid=0 next_prio=120
      Traceback (most recent call last):
        File "/var/home/acme/git/perf/tools/perf/python/tracepoint.py", line 48, in <module>
          main()
        File "/var/home/acme/git/perf/tools/perf/python/tracepoint.py", line 37, in main
          print("time %u prev_comm=%s prev_pid=%d prev_prio=%d prev_state=0x%x ==> next_comm=%s next_pid=%d next_prio=%d" % (
      BrokenPipeError: [Errno 32] Broken pipe
      #
    
    Signed-off-by: Tanu M <tanu235m@gmail.com>
    Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
    Cc: Jiri Olsa <jolsa@kernel.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Link: https://lore.kernel.org/linux-perf-users/CAPS78prawYzRZnyhWjgOnGw4EwoswNwztvfZFdCOPOydFzVwzQ@mail.gmail.com
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/python/tracepoint.py b/tools/perf/python/tracepoint.py
index 461848c7f57dca3d..bba68a6d45156183 100755
--- a/tools/perf/python/tracepoint.py
+++ b/tools/perf/python/tracepoint.py
@@ -34,7 +34,7 @@ def main():
             if not isinstance(event, perf.sample_event):
                 continue
 
-            print "time %u prev_comm=%s prev_pid=%d prev_prio=%d prev_state=0x%x ==> next_comm=%s next_pid=%d next_prio=%d" % (
+            print("time %u prev_comm=%s prev_pid=%d prev_prio=%d prev_state=0x%x ==> next_comm=%s next_pid=%d next_prio=%d" % (
                    event.sample_time,
                    event.prev_comm,
                    event.prev_pid,
@@ -42,7 +42,7 @@ def main():
                    event.prev_state,
                    event.next_comm,
                    event.next_pid,
-                   event.next_prio)
+                   event.next_prio))
 
 if __name__ == '__main__':
     main()


- Arnaldo
