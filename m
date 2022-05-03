Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1376E518C6A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 20:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241544AbiECSfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 14:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241399AbiECSeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 14:34:50 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C863F89F
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 11:31:05 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id l6-20020a170903120600b0014f43ba55f3so8251941plh.11
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 11:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PH+xG6MpJgOWP4Nd5wbkgZPXGVxwqiuyEnG1R2LsJQQ=;
        b=GELegNYt7SuUFUfWOpcWuqF4CQjFOL1qCR3ckZDviaWyVJAl+zmPfWpNqVPzTXDXHc
         ZAkQqE90tJVIPKEjYTKhwA6OSIt8wfHOVRjew7839NmsmSelV99i1MzB0Sn/i87v4ELp
         wFstXhIhWniFuji/fvIVWJIILUtKPxKRIyYsi7WmbRcSjz8koDflEs9CZRt1z7X4KXJT
         RsCwZCCSeykNJ8fhz5BbYNZX4Ss+r6DUgCkK4Bs2nps/iW/gqrsAGGvgWmSJpERX3Bez
         XdAzDW7KcP/jDIiPn9reOWhUYM/yH0/RF8UhGHdsI8jqrGmayL/qYsWO9TNVl07E67vg
         gf9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PH+xG6MpJgOWP4Nd5wbkgZPXGVxwqiuyEnG1R2LsJQQ=;
        b=FCyyUgao7Nz9h4FwEDkie51iUT5dXc7gfuPgYXrnuTfqwsbZih61DlV4UAXlNY3lKw
         NJW5uelOCFvwCrD+J96DOC8Bz9J+TiJIW6QEnjRzJxYQ7WYX1etNbAs2MirZwxb3NGD+
         pNf1IBDJAIJJ387TCrlhE4dZnTDQtHIX7QaSPMMgJucdvISaTwJzGN4DdPWWxPNXiE3P
         r80wqZ9fbHq50Sc64kYT38TOd7AzDQp/ngr7lBtaO4Rf34dt9Mqn3o+oG4+bYksn7vqv
         vFbu+dP2oRHCCp2JkpLwIZqxG2nxJlDO+pimGW6Dhkd9s7b+PsU/dSh2Lzlfc+t5IMd2
         TkJQ==
X-Gm-Message-State: AOAM530HGQ+yrOoNSGE6LuDTdFFrtKKYerQBvpDEHIAU6xAVTs5v/iDR
        TcGsbKLQxi1efokfwd8oCIsy/nk5pEDCGy73E96gLHYP5UE2AAAzZI4b9QETjbGPsbGOZsMXNsw
        WJjZTzCHTsvGa8mM5bj4xuTfpx8jkiORWpYy9U5iUdkEsq0YqI6UJ7nbZbGF4IzCNAHDPs8Ue
X-Google-Smtp-Source: ABdhPJxDr77DJ1rH+k3RFe0iH6545KQm+EtT7iY4DHLcjsZKZHMBguFZE6i+E8tvMW70pQfVeFBI4O+/Ytq/
X-Received: from sweer.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:e45])
 (user=bgardon job=sendgmr) by 2002:a17:902:e550:b0:15c:f4f2:814f with SMTP id
 n16-20020a170902e55000b0015cf4f2814fmr17804676plf.123.1651602664332; Tue, 03
 May 2022 11:31:04 -0700 (PDT)
Date:   Tue,  3 May 2022 18:30:44 +0000
In-Reply-To: <20220503183045.978509-1-bgardon@google.com>
Message-Id: <20220503183045.978509-11-bgardon@google.com>
Mime-Version: 1.0
References: <20220503183045.978509-1-bgardon@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v7 10/11] KVM: selftests: Test disabling NX hugepages on a VM
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        David Matlack <dmatlack@google.com>,
        Jim Mattson <jmattson@google.com>,
        David Dunn <daviddunn@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Junaid Shahid <junaids@google.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an argument to the NX huge pages test to test disabling the feature
on a VM using the new capability.

Reviewed-by: David Matlack <dmatlack@google.com>
Signed-off-by: Ben Gardon <bgardon@google.com>
---
 .../selftests/kvm/include/kvm_util_base.h     |  2 +
 tools/testing/selftests/kvm/lib/kvm_util.c    | 27 ++++++-
 .../selftests/kvm/x86_64/nx_huge_pages_test.c | 70 +++++++++++++++----
 .../kvm/x86_64/nx_huge_pages_test.sh          | 12 +++-
 4 files changed, 95 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 1dac3c6607f1..eee96189c1c4 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -414,4 +414,6 @@ uint64_t vm_get_stat(struct kvm_vm *vm, const char *stat_name);
 
 uint32_t guest_get_vcpuid(void);
 
+int __vm_disable_nx_huge_pages(struct kvm_vm *vm);
+
 #endif /* SELFTEST_KVM_UTIL_BASE_H */
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 27ffd2537df6..0ec7efc2900d 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -112,6 +112,11 @@ int vm_check_cap(struct kvm_vm *vm, long cap)
 	return ret;
 }
 
+static int __vm_enable_cap(struct kvm_vm *vm, struct kvm_enable_cap *cap)
+{
+	return ioctl(vm->fd, KVM_ENABLE_CAP, cap);
+}
+
 /* VM Enable Capability
  *
  * Input Args:
@@ -128,7 +133,7 @@ int vm_enable_cap(struct kvm_vm *vm, struct kvm_enable_cap *cap)
 {
 	int ret;
 
-	ret = ioctl(vm->fd, KVM_ENABLE_CAP, cap);
+	ret = __vm_enable_cap(vm, cap);
 	TEST_ASSERT(ret == 0, "KVM_ENABLE_CAP IOCTL failed,\n"
 		"  rc: %i errno: %i", ret, errno);
 
@@ -2758,3 +2763,23 @@ uint64_t vm_get_stat(struct kvm_vm *vm, const char *stat_name)
 		    stat_name, ret);
 	return data;
 }
+
+/* VM disable NX huge pages
+ *
+ * Input Args:
+ *   vm - Virtual Machine
+ *
+ * Output Args: None
+ *
+ * Return: On success, 0 -ERRNO on failure.
+ *
+ * Disables NX huge pages for the VM.
+ */
+int __vm_disable_nx_huge_pages(struct kvm_vm *vm)
+{
+	struct kvm_enable_cap cap = { 0 };
+
+	cap.cap = KVM_CAP_VM_DISABLE_NX_HUGE_PAGES;
+	cap.args[0] = 0;
+	return __vm_enable_cap(vm, &cap);
+}
diff --git a/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c b/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c
index 238a6047791c..1e7328dd33d2 100644
--- a/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c
+++ b/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c
@@ -13,6 +13,8 @@
 #include <fcntl.h>
 #include <stdint.h>
 #include <time.h>
+#include <linux/reboot.h>
+#include <sys/syscall.h>
 
 #include <test_util.h>
 #include "kvm_util.h"
@@ -89,18 +91,36 @@ static void check_split_count(struct kvm_vm *vm, int expected_splits)
 		    expected_splits, actual_splits);
 }
 
-int main(int argc, char **argv)
+void run_test(bool disable_nx_huge_pages, bool reboot_permissions)
 {
 	struct kvm_vm *vm;
 	struct timespec ts;
+	uint64_t pages;
 	void *hva;
-
-	if (argc != 2 || strtol(argv[1], NULL, 0) != MAGIC_TOKEN) {
-		printf("This test must be run through nx_huge_pages_test.sh");
-		return KSFT_SKIP;
+	int r;
+
+	pages = vm_pages_needed(VM_MODE_DEFAULT, 1, DEFAULT_GUEST_PHY_PAGES,
+				0, 0);
+	vm = vm_create_without_vcpus(VM_MODE_DEFAULT, pages);
+
+	if (disable_nx_huge_pages) {
+		/*
+		 * Cannot run the test without NX huge pages if the kernel
+		 * does not support it.
+		 */
+		if (!kvm_check_cap(KVM_CAP_VM_DISABLE_NX_HUGE_PAGES))
+			return;
+
+		r = __vm_disable_nx_huge_pages(vm);
+		if (reboot_permissions) {
+			TEST_ASSERT(!r, "Disabling NX huge pages should succeed if process has reboot permissions");
+		} else {
+			TEST_ASSERT(r == -EPERM, "This process should not have permission to disable NX huge pages");
+			return;
+		}
 	}
 
-	vm = vm_create_default(0, 0, guest_code);
+	vm_vcpu_add_default(vm, 0, guest_code);
 
 	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS_HUGETLB,
 				    HPAGE_GPA, HPAGE_SLOT,
@@ -133,23 +153,27 @@ int main(int argc, char **argv)
 	/*
 	 * Next, the guest will execute from the first huge page, causing it
 	 * to be remapped at 4k.
+	 *
+	 * If NX huge pages are disabled, this should have no effect.
 	 */
 	vcpu_run(vm, 0);
-	check_2m_page_count(vm, 1);
-	check_split_count(vm, 1);
+	check_2m_page_count(vm, disable_nx_huge_pages ? 2 : 1);
+	check_split_count(vm, disable_nx_huge_pages ? 0 : 1);
 
 	/*
 	 * Executing from the third huge page (previously unaccessed) will
 	 * cause part to be mapped at 4k.
+	 *
+	 * If NX huge pages are disabled, it should be mapped at 2M.
 	 */
 	vcpu_run(vm, 0);
-	check_2m_page_count(vm, 1);
-	check_split_count(vm, 2);
+	check_2m_page_count(vm, disable_nx_huge_pages ? 3 : 1);
+	check_split_count(vm, disable_nx_huge_pages ? 0 : 2);
 
 	/* Reading from the first huge page again should have no effect. */
 	vcpu_run(vm, 0);
-	check_2m_page_count(vm, 1);
-	check_split_count(vm, 2);
+	check_2m_page_count(vm, disable_nx_huge_pages ? 3 : 1);
+	check_split_count(vm, disable_nx_huge_pages ? 0 : 2);
 
 	/*
 	 * Give recovery thread time to run. The wrapper script sets
@@ -161,8 +185,11 @@ int main(int argc, char **argv)
 
 	/*
 	 * Now that the reclaimer has run, all the split pages should be gone.
+	 *
+	 * If NX huge pages are disabled, the relaimer will not run, so
+	 * nothing should change from here on.
 	 */
-	check_2m_page_count(vm, 1);
+	check_2m_page_count(vm, disable_nx_huge_pages ? 3 : 1);
 	check_split_count(vm, 0);
 
 	/*
@@ -170,10 +197,25 @@ int main(int argc, char **argv)
 	 * reading from it causes a huge page mapping to be installed.
 	 */
 	vcpu_run(vm, 0);
-	check_2m_page_count(vm, 2);
+	check_2m_page_count(vm, disable_nx_huge_pages ? 3 : 2);
 	check_split_count(vm, 0);
 
 	kvm_vm_free(vm);
+}
+
+int main(int argc, char **argv)
+{
+	bool reboot_permissions;
+
+	if (argc != 3 || strtol(argv[1], NULL, 0) != MAGIC_TOKEN) {
+		printf("This test must be run through nx_huge_pages_test.sh");
+		return KSFT_SKIP;
+	}
+
+	reboot_permissions = strtol(argv[2], NULL, 0);
+
+	run_test(false, reboot_permissions);
+	run_test(true, reboot_permissions);
 
 	return 0;
 }
diff --git a/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.sh b/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.sh
index 60bfed8181b9..c21c1f639141 100755
--- a/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.sh
+++ b/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.sh
@@ -16,6 +16,8 @@ HUGE_PAGES=$(sudo cat /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages)
 
 set +e
 
+NXECUTABLE="$(dirname $0)/nx_huge_pages_test"
+
 (
 	set -e
 
@@ -24,7 +26,15 @@ set +e
 	sudo echo 100 > /sys/module/kvm/parameters/nx_huge_pages_recovery_period_ms
 	sudo echo 3 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
 
-	"$(dirname $0)"/nx_huge_pages_test 887563923
+	# Test with reboot permissions
+	sudo setcap cap_sys_boot+ep $NXECUTABLE
+	$NXECUTABLE 887563923 1
+
+	# Test without reboot permissions
+	if [ $(whoami) != "root" ] ; then
+		sudo setcap cap_sys_boot-ep $NXECUTABLE
+		$NXECUTABLE 887563923 0
+	fi
 )
 RET=$?
 
-- 
2.36.0.464.gb9c8b46e94-goog

