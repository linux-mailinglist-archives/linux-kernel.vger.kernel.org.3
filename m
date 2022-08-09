Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3CF458D841
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 13:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242763AbiHILf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 07:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242833AbiHILfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 07:35:24 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBDB22B01;
        Tue,  9 Aug 2022 04:34:57 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 2AE7F3200979;
        Tue,  9 Aug 2022 07:34:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 09 Aug 2022 07:34:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1660044895; x=1660131295; bh=sG3dfW2+8uHUHlEdheiLB6CAO
        Rlgb6+iLDptt+xl+L4=; b=pytOGLqMrHrV0vUIbND1YlQwelLouQz9EKwI5BOd0
        /n9laR37cD8SDdJsrtVtaVR1zI+Fq8It8MMfkU8YJG1MpmEXr4V/rpTpqxe2e8yw
        WijGkZRuTk79aiQgf8g6ng26Uljbhec/PvBVh5yZW44n/9uY8gUow4/lbqGicWwY
        vHywdMVRFP008CpLNTrW23EdCL02CH/VjQTzTKP6RM1S+FS7D2C4GRoThJk3lHuk
        wvB3ZA1gDSdQffqRehPwHttJ42O8/lgfiKGBDUYEhDoN7tgL4zEnouNkIOEXoF1Q
        Y5lvIaFheK2UzKKF7ADNS2wRluAGltiop66+0KPjoPWeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1660044895; x=1660131295; bh=sG3dfW2+8uHUHlEdheiLB6CAORlgb6+iLDp
        tt+xl+L4=; b=xG9yL5lsuZcEkpa6OC61vDWSwOkV6A1Mr5sghZ1UGdyXwqfSalS
        qx91TGjx7f0mjd1YowwyLvMzpeTSkSPqYSfbeI4oazw+/HPuboxvGYDbeW4Iz4fo
        1aMSSpn6iWeYgupeOfH9HtMfZnDm+GprIHozgwW+cx/l+f6WV1Z/VbOPTR1ZdoZd
        i82icUvLXmKTBq4UWPIWbb+DBZyZXJqQPRjOBLUBNcZqp6Q8/L2YNEeJfBFsioq4
        pKmjWpyjfqtLaAP/9LpXycMJfCdjKr4iaN8hT57ZMGplNqH+dgAvIjTct45+RMvW
        yV+pbWK+KKUYLQv0KP3BAklWBr5g/uijwKw==
X-ME-Sender: <xms:X0byYsFpwaLn58nEbDYXxHus6b9Hl-_tWx_WlDrsK3CAJBuf8rJUcQ>
    <xme:X0byYlWJPzU084IRx1lTBnD97Z8E_yISirIUwol_MGbaHlxY1Qjy95PGYlip_spz2
    QdUAZBmc4fb_Sk9uwo>
X-ME-Received: <xmr:X0byYmIvLAnDKdLnHgkeEO5Wfv_zgLWS8Nr51lwIWtC5QDy-OZmAV10NMkPCqsJVOc6t6yjPOItSWpi7OG-mjWOcvOVhXPA3pm_7SKwql9XYwbbHh_V4GKKk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdegtddggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghes
    fhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhephfetuddtudevieeljeejte
    ffheeujeduhefgffejudfhueelleduffefgfffveeknecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgoh
    grthdrtghomh
X-ME-Proxy: <xmx:X0byYuGknYmkQBuCY2GJ0tem1zQUq4s2p1-kd9ivUasX6XlfxlZSjQ>
    <xmx:X0byYiUe8ZPR-bxFGY7kZP-rMObb_C0cWKcyP14qEq3GwRn-15JsVA>
    <xmx:X0byYhOwwf95n7oqO2Zq2603G1nxw1u3e6ExG0anOP3K193XSJx9-Q>
    <xmx:X0byYhTlummVrvgyMCGN3Me02FLFQ0AIHC3-ks_Ye97LpDzxBJPuGQ>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Aug 2022 07:34:54 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        linux-api@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH] MIPS: Expose prid and globalnumber to sysfs
Date:   Tue,  9 Aug 2022 11:34:44 +0000
Message-Id: <20220809113444.17757-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
index 9429d85a4703..90b5136afb63 100644
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
+static DEFINE_PER_CPU(struct cpureg, cpuregs);
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

