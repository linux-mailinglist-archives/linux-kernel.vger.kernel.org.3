Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A281657E6C3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 20:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235149AbiGVSmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 14:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236438AbiGVSmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 14:42:23 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40647A8763;
        Fri, 22 Jul 2022 11:42:21 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id 51971c5b48ec7a62; Fri, 22 Jul 2022 20:42:19 +0200
Received: from kreacher.localnet (unknown [213.134.181.41])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 9CC5B66CAF7;
        Fri, 22 Jul 2022 20:42:18 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Di Shen <di.shen@unisoc.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jeson.gao@unisoc.com, xuewen.yan@unisoc.com, cindygm567@gmail.com
Subject: Re: [PATCH V2 1/1] thermal/sysfs: Clear cooling_device_stats_attr_group before initialized
Date:   Fri, 22 Jul 2022 20:42:17 +0200
Message-ID: <12043680.O9o76ZdvQC@kreacher>
In-Reply-To: <CAJZ5v0iKWH2QkztewmJXiqGwnzBxCo5MWni9Q3VODwV+huvuQA@mail.gmail.com>
References: <20220722084314.17816-1-di.shen@unisoc.com> <CAJZ5v0iKWH2QkztewmJXiqGwnzBxCo5MWni9Q3VODwV+huvuQA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.181.41
X-CLIENT-HOSTNAME: 213.134.181.41
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrudelkedguddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppedvudefrddufeegrddukedurdegudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddukedurdeguddphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepuddupdhrtghpthhtohepughirdhshhgvnhesuhhnihhsohgtrdgtohhmpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopehvihhrvghshhdrkhhumhgrrheslhhinhgr
 rhhordhorhhgpdhrtghpthhtoheprghmihhtkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgvshhonhdrghgrohesuhhnihhsohgtrdgtohhmpdhrtghpthhtohepgihuvgifvghnrdihrghnsehunhhishhotgdrtghomhdprhgtphhtthhopegtihhnugihghhmheeijeesghhmrghilhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=11 Fuz1=11 Fuz2=11
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, July 22, 2022 7:18:42 PM CEST Rafael J. Wysocki wrote:
> On Fri, Jul 22, 2022 at 10:44 AM Di Shen <di.shen@unisoc.com> wrote:
> >
> > There's a space allocated for cooling_device_stats_attr_group
> > within cooling_device_attr_groups. This space is shared by all
> > cooling devices.
> 
> That's correct.
> 
> > If the stats structure of one cooling device successfully
> > creates stats sysfs. After that, another cooling device fails
> > to get max_states in cooling_device_stats_setup(). It can
> > return directly without initializing the stats structure, but
> > the cooling_device_stats_attr_group is still the attribute
> > group of the last cooling device.
> 
> I cannot parse the above, sorry.
> 
> For example, how can a "stats structure of one cooling device" create
> anything?   As a data structure, it is a passive entity, so it doesn't
> carry out any actions.
> 
> I think (but I am not sure) that you are referring to the error code
> path in which the ->get_max_state() callback fails for a cooling
> device after cooling_device_stats_setup() has completed successfully
> for another one.
> 
> > At this time, read or write stats sysfs nodes can cause kernel
> > crash. Like the following, kernel crashed when
> > 'cat time_in_state_ms'.
> >
> > [<5baac8d4>] panic+0x1b4/0x3c8
> > [<9d287b0f>] arm_notify_die+0x0/0x78
> > [<094fc22c>] __do_kernel_fault+0x94/0xa4
> > [<3b4b69a4>] do_page_fault+0xd4/0x364
> > [<23793e7a>] do_translation_fault+0x38/0xc0
> > [<6e5cc52a>] do_DataAbort+0x4c/0xd0
> > [<a28c16b8>] __dabt_svc+0x5c/0xa0
> > [<747516ae>] _raw_spin_lock+0x20/0x60
> > [<9a9e4cd4>] time_in_state_ms_show+0x28/0x148
> > [<cb78325e>] dev_attr_show+0x38/0x64
> > [<aea3e364>] sysfs_kf_seq_show+0x8c/0xf0
> > [<c0a843ab>] seq_read+0x244/0x620
> > [<b316b374>] vfs_read+0xd8/0x218
> > [<3aebf5fa>] sys_read+0x80/0xe4
> > [<7cf100f5>] ret_fast_syscall+0x0/0x28
> > [<08cbe22f>] 0xbe8c1198
> >
> > stats sysfs:
> > phone:/sys/class/thermal/cooling_device2/stats # ls
> > reset  time_in_state_ms  total_trans  trans_table
> >
> > The same as cat total_trans, trans_table, and echo reset.

So does the (untested) patch below work too?

---
 drivers/thermal/thermal_sysfs.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/thermal/thermal_sysfs.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_sysfs.c
+++ linux-pm/drivers/thermal/thermal_sysfs.c
@@ -813,12 +813,13 @@ static const struct attribute_group cool
 
 static void cooling_device_stats_setup(struct thermal_cooling_device *cdev)
 {
+	const struct attribute_group *stats_attr_group = NULL;
 	struct cooling_dev_stats *stats;
 	unsigned long states;
 	int var;
 
 	if (cdev->ops->get_max_state(cdev, &states))
-		return;
+		goto out;
 
 	states++; /* Total number of states is highest state + 1 */
 
@@ -828,7 +829,7 @@ static void cooling_device_stats_setup(s
 
 	stats = kzalloc(var, GFP_KERNEL);
 	if (!stats)
-		return;
+		goto out;
 
 	stats->time_in_state = (ktime_t *)(stats + 1);
 	stats->trans_table = (unsigned int *)(stats->time_in_state + states);
@@ -838,9 +839,12 @@ static void cooling_device_stats_setup(s
 
 	spin_lock_init(&stats->lock);
 
+	stats_attr_group = &cooling_device_stats_attr_group;
+
+out:
 	/* Fill the empty slot left in cooling_device_attr_groups */
 	var = ARRAY_SIZE(cooling_device_attr_groups) - 2;
-	cooling_device_attr_groups[var] = &cooling_device_stats_attr_group;
+	cooling_device_attr_groups[var] = stats_attr_group;
 }
 
 static void cooling_device_stats_destroy(struct thermal_cooling_device *cdev)



