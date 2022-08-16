Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A928595782
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 12:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbiHPKHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 06:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234312AbiHPKGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:06:48 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C10D6C13B;
        Tue, 16 Aug 2022 02:13:09 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id B97AD5C023C;
        Tue, 16 Aug 2022 05:13:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 16 Aug 2022 05:13:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1660641186; x=1660727586; bh=8a1Us8uLfYqD/kfLMEoeT8k8O
        knxiZLX1kGLg+OrAM4=; b=r6H+8a3y5yj7F0UBxWS3xmNGJ4AZCoV08iA9aYSiG
        iIUMD0BVkiArJeidyP3+THHDgukkHtiYS2rV2+5jEczyQJWOJxa+ZTlU/LZywIWS
        jIn0WD0vtvdAsrpKUe75BD5Vx/SgInIM8oyeFBWYjnul23Yq+Jc1VhQXQITkEX9X
        8zs6nw70KAkOukTTHFd4WAytOG+3ydSI1JQuJTvF9oLI9+cHiDr15mPHkj3ROJsn
        GzolNxC7i1+u7A9MSZNbGTYdtofb7F5t4LMWGpcCg3ovJpYAwi+ENSePxTE1uFI4
        GcG0mtNLrBJAjou8YRD3LVd+XUzGW770AE4pH7tIXRvrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1660641186; x=1660727586; bh=8a1Us8uLfYqD/kfLMEoeT8k8OknxiZLX1kG
        Lg+OrAM4=; b=wrYGYkzDiCXY2jq9yVfNlwFSOW1/NZDsNT4xf02gU7Drm1Ei1QJ
        NJiG9y7Vqv95PxaclaFAxVInyTQjKlZScb4tpZip+4HPtydJDOre9VjpLJjZQUbY
        vMaNQm3i3OrdILpnDNqtBLyKJ/gnptxLxMo8UZ+Nnc8RB4EDuTbaat4f7Eha2+VK
        dbVzXpccV2JY2643CcTGcd97TU5fz1msF9n5JBFo6E7VgKk92FrTeX/vREcE6mr1
        1TzcvdmZPxzFpDa3F/Piz+LcbnzQ3zrQbljtlPw7k4Ds7tGE8TVCoYa8lFtP6c65
        qBsGmMExD8Tcxq8R3qp4HMEQbsmvRQnt9dw==
X-ME-Sender: <xms:ol_7YgtxxlMA42cgcxr0bVkHAmattxopCO_l9CI8J6QblsGfqubOUw>
    <xme:ol_7YtcfKP1ox8rn6hoG4fMB6BPI6kxmW4owEBEs35Z21K-I0_jPQkwtT8nKngl2x
    OYWqvRumZocdqE_GTU>
X-ME-Received: <xmr:ol_7YrwQRZpYNfse4O4jlQKtMJOfkvzWMHvHCsT_fjOyjKHnK_N75aEm_uHQNvn008a8o0B_WTaTdQldztknVG5Gw2HKWZEKfFlGf80nNQ-4x2TIItzR7JfG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehgedgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghes
    fhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhephfetuddtudevieeljeejte
    ffheeujeduhefgffejudfhueelleduffefgfffveeknecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgoh
    grthdrtghomh
X-ME-Proxy: <xmx:ol_7YjN0pHaGH713wYRLYfbjQbtuSU04CsZyS0JOSOEjfhTJMUmyPg>
    <xmx:ol_7Yg8Qs9kdGRzPVQJgiJ8YxL0TNtXbWC_ML7BEiVc2SQR5IKYjSA>
    <xmx:ol_7YrXsZeKZ0I5zREdmRUXKuaHtn1heGrrn8czkR53XWaFV4WJw2w>
    <xmx:ol_7Yvkeo-Dttf3JulnEP_ywlgJvVFLVbZJRVwrNLQ51D415F7pWaQ>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Aug 2022 05:13:05 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        linux-api@vger.kernel.org, greg@kroah.com, f.fainelli@gmail.com,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v4] MIPS: Expose prid and globalnumber to sysfs
Date:   Tue, 16 Aug 2022 09:12:58 +0000
Message-Id: <20220816091258.9571-1-jiaxun.yang@flygoat.com>
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
v4: Properly handle err of kobj creation. (gregkh)
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
index 9429d85a4703..45a15eda651a 100644
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
+	kobject_put(&reg->kobj);
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
+		kobject_put(&reg->kobj);
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

