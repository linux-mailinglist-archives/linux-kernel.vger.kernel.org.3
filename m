Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1119F5933A6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 18:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbiHOQ5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 12:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbiHOQ5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 12:57:11 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D180275C1;
        Mon, 15 Aug 2022 09:57:07 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id C634C5C00A9;
        Mon, 15 Aug 2022 12:57:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 15 Aug 2022 12:57:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1660582626; x=1660669026; bh=Ol1vZQMDzQJ/UfaV4djAjHutl
        ohkGJidWHRjUdixpVo=; b=x/OuqusICqcvuOKW68PLhWc6i4McmfcwFYAHiHklP
        gJVqJsRTdoK8CEfhw/OKkjQG9l67Sn6FwJjPDZGZLH1bHFqn6lopAhZsB/Fma7WV
        bw4BY4Y3p2a6MNnKL/BjCIs05AsSLLfx+3ykG6IbAHmkgNs6wJZPp9je3iMlrqPv
        3qVbSK0JzzT1puf7pyLCNOk8R0ycVasBq88ip5UzR1rwTvs9O6y7DqHPOyhYC9HX
        Wy2czMqhn4OcIssk+hwY6sRVPD9DuENE+Pywz13P2Pa/iZwxgWxoq9WlvRlD03tH
        NRta3yl67r3w6imOZlhEYjiUPlpgoqVgT389ygoDFLKew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1660582626; x=1660669026; bh=Ol1vZQMDzQJ/UfaV4djAjHutlohkGJidWHR
        jUdixpVo=; b=N8X1NZ/vz5dy2p5j9z6GbidEljoeZTkBxfFuy+EcBpa7vBLoXuA
        xNJOc+Cc9k7PXgtxQCK7FuqKsOilzwxNn1ihsz3JvxsIUF35VpAYo4KKuW0RPr91
        IoTaIGC84H6v/mvaBIyM1+6BbWKdBDgukJ4JkYfsEh2HBR+2llnchOq0Kc0nfudI
        Q6b/fFzigdlktTc3kq5xA4XJpcuWmMx6s6shVNZpbyr1m0Gec3xvbI9uQOZvqz/9
        6PGA+qUZkKH7XIwp/9DRVtNkukRg7TIIBNsAgw669KGFN7bYW6DEYOM/wgpPMG8z
        WS3N4OzVs8S0wqeYULrfcRV1tdw0Wtkh3gQ==
X-ME-Sender: <xms:4nr6Yjf42Fbz5XyPiWMZHjLUanoINeYXI9iUJ80XSfhNJYOz1Pauyw>
    <xme:4nr6YpM1DbZYLfJ21QZh0VkIYIN_v3cO2hBc86bqFbCCGFHc5SAAAhEaaZZ8zPlNI
    75tUbxYgfXM1TLXPrk>
X-ME-Received: <xmr:4nr6Ysg5pjbXfhEZ4x6Sh-yrgxfN_q_8Uo3eeFrlZV79BXWIqUsGSbkMl_JLJO7eA0fC_ZwRBrjUMNKDRqNVVej7mO8xeJKxSytErK6jdO4abQ48KobVTCse>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehvddguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekre
    dtredttdenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhg
    sehflhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpefhtedutdduveeileejje
    etffehueejudehgfffjeduhfeuleeludfffefgffevkeenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihgh
    horghtrdgtohhm
X-ME-Proxy: <xmx:4nr6Yk-285XV4M837Lz7eQ1eB3-3aMfAaJykBrchctogaP6fQEYAjA>
    <xmx:4nr6Yvtdp51Jx751KVB5HLW7dMYk8xXu4wAfRWnbuUG0Sxa3UBGMWA>
    <xmx:4nr6YjEi_UynVNjtqCFMwzyQiVJEUQbBQpPNa58nzPpXOLbfOTKPBw>
    <xmx:4nr6YlWGpdpJ83lazjcxYE6JwlpRzE7L4Acju9VmSYzapahVfEEZoA>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Aug 2022 12:57:05 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        linux-api@vger.kernel.org, greg@kroah.com, f.fainelli@gmail.com,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v3] MIPS: Expose prid and globalnumber to sysfs
Date:   Mon, 15 Aug 2022 16:56:58 +0000
Message-Id: <20220815165658.11887-1-jiaxun.yang@flygoat.com>
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
v2: Drop static qualifier for kobj (gregkh)
v3: Use kzalloc to allocate struct cpuregs.
    note: When Greg mentioned about static I was thinking about
    static qualifier of percpu variable. After reading documents
    again it turns out kobjs should be allocated at runtime. Arm64's
    cpuinfo kobj is also on a percpu variable... I guess that was a
    intentional use?
---
 .../ABI/testing/sysfs-devices-system-cpu      |  11 ++
 arch/mips/kernel/topology.c                   | 103 ++++++++++++++++++
 2 files changed, 114 insertions(+)

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
index 9429d85a4703..bbb7d4b51ffe 100644
--- a/arch/mips/kernel/topology.c
+++ b/arch/mips/kernel/topology.c
@@ -5,6 +5,8 @@
 #include <linux/node.h>
 #include <linux/nodemask.h>
 #include <linux/percpu.h>
+#include <linux/seq_file.h>
+#include <linux/smp.h>
 
 static DEFINE_PER_CPU(struct cpu, cpu_devices);
 
@@ -26,3 +28,104 @@ static int __init topology_init(void)
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
+static DEFINE_PER_CPU(struct cpureg *, cpuregs);
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
+	struct cpureg *reg;
+
+	dev = get_cpu_device(cpu);
+	if (!dev) {
+		rc = -ENODEV;
+		goto out;
+	}
+	reg = kzalloc(sizeof(struct cpureg), GFP_KERNEL);
+	if (!reg) {
+		rc = -ENOMEM;
+		goto out;
+	}
+	rc = kobject_init_and_add(&reg->kobj, &cpuregs_kobj_type,
+					&dev->kobj, "regs");
+	if (rc)
+		goto out_kfree;
+	rc = sysfs_create_group(&reg->kobj, &cpuregs_attr_group);
+	if (rc)
+		goto out_kobj;
+
+	return 0;
+out_kobj:
+	kobject_del(&reg->kobj);
+out_kfree:
+	kfree(reg);
+out:
+	return rc;
+}
+
+static int cpuregs_cpu_offline(unsigned int cpu)
+{
+	struct device *dev;
+	struct cpureg *reg = per_cpu(cpuregs, cpu);
+
+	dev = get_cpu_device(cpu);
+	if (!dev || !reg)
+		return -ENODEV;
+	if (reg->kobj.parent) {
+		sysfs_remove_group(&reg->kobj, &cpuregs_attr_group);
+		kobject_del(&reg->kobj);
+	}
+	kfree(reg);
+
+	return 0;
+}
+
+static int __init cpuinfo_regs_init(void)
+{
+	int ret;
+
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

