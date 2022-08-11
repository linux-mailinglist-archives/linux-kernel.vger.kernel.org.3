Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D618558FA88
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 12:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbiHKKMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 06:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233309AbiHKKMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 06:12:51 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5194D13F95;
        Thu, 11 Aug 2022 03:12:50 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id DB0085C00DC;
        Thu, 11 Aug 2022 06:12:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 11 Aug 2022 06:12:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1660212767; x=1660299167; bh=mMS4E3mqOTH7Zvgf4rLhChkDS
        DL/NPafGJ3IH/CpISU=; b=mulhKIlx3oKssza3LcaRu+tNLTT/dx7ry/BeC9Ldu
        7uJ9t3hg12HE5EwaOv8nlQ2ehWsx/+pJmgityjikL5DW9KTIt4fNF8Qt30Bf3rGb
        bl3K3hswYC8+EwC/Z1gw5UCg/rPO7GICq2wPtEp9gso3qu+qiQiC1bOx6F4v2UlY
        2THESXLyfCU7sPX3H5MJ5QcMqijWP31iAJ1dQbJqq2kMFKwT8Fmgy4nn4kMxwmvT
        50EIcdDxznNvgsmbzMZNMUL+1++03c9NvGsUXviWMNWWX3MZxQIL4S5UFeX7mos/
        FRsUP1X8vNhT0pHo0TKzuszDHohvRZVvbHO9rkRIyiwTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1660212767; x=1660299167; bh=mMS4E3mqOTH7Zvgf4rLhChkDSDL/NPafGJ3
        IH/CpISU=; b=q5TyV+pyZIpzZENBOZAjvIz+0M67h5Sz5eaMC7RpZHr+Jj5qum0
        1BfhjSiQsXRk70i3pgensy/vuKNEU86WXz1KJQ5eI6BymeOsMP56No88F9/jDutl
        RTlQG//DmXvx+c4/3uCMRrb8mDSy0djRFR4oDqmnfaMLnK3yyKPweCKiH2QlrECv
        SonO04a1dPWc9eEAeNmPmCYGhSq+t48j15U0PX9+z5VS1T4Fu9ztl8IJPcFwfGE4
        0eRRUPBuEaRAH18lVAMnsIKThCwo/n2S1IEeITVuID83EY73ZzeLW3+ZFnO9+Mdn
        ots8pMXpyVxy8OYjD2ox5yhfNSrE0kVAXDQ==
X-ME-Sender: <xms:H9b0YpPfHfWuTqVftNX6_dgqe17ZXGEL3EGULhZ_TniV6-elaN7AKg>
    <xme:H9b0Yr9fEBJ3mG_ur0xF0uG3M2KSvckkle-OVSnPP_KC_3T1vwj1JX-0pj-ratEK6
    f8oFv7Gn0oDHVub9Ok>
X-ME-Received: <xmr:H9b0YoS2ckT8sNcO1dDwIVYINhirlOp8JE-F1l7Zv6AOiIDrtgCJMcumep1EcY_SAP6KgZwOrHgKNlSYpolvsKseHc8_zUEjeciOqY1i1QP1mURD_ve8khGK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeggedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghes
    fhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhephfetuddtudevieeljeejte
    ffheeujeduhefgffejudfhueelleduffefgfffveeknecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgoh
    grthdrtghomh
X-ME-Proxy: <xmx:H9b0Ylu6ZTP0uo3Rx-kjCqyFzZKSOz7UeWJ7HxbiW62qRty2M6UiWg>
    <xmx:H9b0Yhff5TmWvYQjBLsRpT0cKEXeuEJMnWV74VMC3gJwHTlf7bA3eg>
    <xmx:H9b0Yh1DaUnzYVaKzdVp5H4ZzIf3asSPdwV2g1uU-Y1P9sCc7n102Q>
    <xmx:H9b0Yl4PGnM7HxNEgGbbsHa9oTlw5AZX_VL-vfnJa-fZk8GFuSF8Rg>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Aug 2022 06:12:45 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        linux-api@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2] MIPS: Expose prid and globalnumber to sysfs
Date:   Thu, 11 Aug 2022 10:12:36 +0000
Message-Id: <20220811101236.1925-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some application would like to know precise model and rev of processor
to do errata workaround or optimization.

Expose them in sysfs as:
/sys/devices/system/cpu/cpuX/regs/identification/prid
/sys/devices/system/cpu/cpuX/regs/identification/globalnumber

Reusing AArch64 CPU registers directory.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
v2: Drop static qualifier for kobj (gregkh)
---
 .../ABI/testing/sysfs-devices-system-cpu      | 11 +++
 arch/mips/kernel/topology.c                   | 96 +++++++++++++++++++
 2 files changed, 107 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 5bf61881f012..adf855e7bb9b 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -512,6 +512,17 @@ Description:	information about CPUs heterogeneity.
 
 		cpu_capacity: capacity of cpuX.
 
+What:		/sys/devices/system/cpu/cpuX/regs/
+		/sys/devices/system/cpu/cpuX/regs/identification/
+		/sys/devices/system/cpu/cpuX/regs/identification/prid
+		/sys/devices/system/cpu/cpuX/regs/identification/globalnumber
+Date:		Augest 2022
+Contact:	Linux MIPS Kernel Mailing list <linux-mips@vger.kernel.org>
+Description:	MIPS CPU registers
+
+		'identification' directory exposes the Processor ID and Global Number
+		registers for identifying model and revision of the CPU.
+
 What:		/sys/devices/system/cpu/vulnerabilities
 		/sys/devices/system/cpu/vulnerabilities/meltdown
 		/sys/devices/system/cpu/vulnerabilities/spectre_v1
diff --git a/arch/mips/kernel/topology.c b/arch/mips/kernel/topology.c
index 9429d85a4703..0e3730f3c00f 100644
--- a/arch/mips/kernel/topology.c
+++ b/arch/mips/kernel/topology.c
@@ -5,6 +5,8 @@
 #include <linux/node.h>
 #include <linux/nodemask.h>
 #include <linux/percpu.h>
+#include <linux/seq_file.h>
+#include <linux/smp.h>
 
 static DEFINE_PER_CPU(struct cpu, cpu_devices);
 
@@ -26,3 +28,97 @@ static int __init topology_init(void)
 }
 
 subsys_initcall(topology_init);
+
+static struct kobj_type cpuregs_kobj_type = {
+	.sysfs_ops = &kobj_sysfs_ops,
+};
+
+struct cpureg {
+	struct kobject kobj;
+	struct cpuinfo_mips *info;
+};
+DEFINE_PER_CPU(struct cpureg, cpuregs);
+
+#define kobj_to_cpureg(kobj)	container_of(kobj, struct cpureg, kobj)
+#define CPUREGS_ATTR_RO(_name, _field)						\
+	static ssize_t _name##_show(struct kobject *kobj,			\
+			struct kobj_attribute *attr, char *buf)			\
+	{									\
+		struct cpuinfo_mips *info = kobj_to_cpureg(kobj)->info;		\
+										\
+		return sprintf(buf, "0x%08x\n", info->_field);	\
+	}									\
+	static struct kobj_attribute cpuregs_attr_##_name = __ATTR_RO(_name)
+
+CPUREGS_ATTR_RO(prid, processor_id);
+CPUREGS_ATTR_RO(globalnumber, globalnumber);
+
+static struct attribute *cpuregs_id_attrs[] = {
+	&cpuregs_attr_prid.attr,
+	&cpuregs_attr_globalnumber.attr,
+	NULL
+};
+
+static const struct attribute_group cpuregs_attr_group = {
+	.attrs = cpuregs_id_attrs,
+	.name = "identification"
+};
+
+static int cpuregs_cpu_online(unsigned int cpu)
+{
+	int rc;
+	struct device *dev;
+	struct cpureg *reg = &per_cpu(cpuregs, cpu);
+
+	dev = get_cpu_device(cpu);
+	if (!dev) {
+		rc = -ENODEV;
+		goto out;
+	}
+	rc = kobject_add(&reg->kobj, &dev->kobj, "regs");
+	if (rc)
+		goto out;
+	rc = sysfs_create_group(&reg->kobj, &cpuregs_attr_group);
+	if (rc)
+		kobject_del(&reg->kobj);
+out:
+	return rc;
+}
+
+static int cpuregs_cpu_offline(unsigned int cpu)
+{
+	struct device *dev;
+	struct cpureg *reg = &per_cpu(cpuregs, cpu);
+
+	dev = get_cpu_device(cpu);
+	if (!dev)
+		return -ENODEV;
+	if (reg->kobj.parent) {
+		sysfs_remove_group(&reg->kobj, &cpuregs_attr_group);
+		kobject_del(&reg->kobj);
+	}
+
+	return 0;
+}
+
+static int __init cpuinfo_regs_init(void)
+{
+	int cpu, ret;
+
+	for_each_possible_cpu(cpu) {
+		struct cpureg *reg = &per_cpu(cpuregs, cpu);
+
+		reg->info = &cpu_data[cpu];
+		kobject_init(&reg->kobj, &cpuregs_kobj_type);
+	}
+
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "mips/topology:online",
+				cpuregs_cpu_online, cpuregs_cpu_offline);
+	if (ret < 0) {
+		pr_err("cpuinfo: failed to register hotplug callbacks.\n");
+		return ret;
+	}
+	return 0;
+}
+
+device_initcall(cpuinfo_regs_init);
-- 
2.34.1

