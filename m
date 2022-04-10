Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE664FAC9F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 10:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234569AbiDJIEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 04:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbiDJIEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 04:04:06 -0400
Received: from m12-11.163.com (m12-11.163.com [220.181.12.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E5FDB5EDFB
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 01:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=phMIT
        xTXbHajpDurnS7DeH4vdYKDLGomBm9yh5aFRck=; b=LM4/PLdlVYnM56tQz0I8h
        QyTGrdJc1Ynwi0oq5sfu59CAVQOeO34CwbrOOR4qTOwVwQM7a5RR92/Fy6BREuS2
        sVDGjQD1LGjzi6y6+mwd1k/tfvxMGqrIzDyb43ElUM8YIkzvf2pj1ASGTjSjamoe
        6+bs/+jbSxVMAX+4wWxnyE=
Received: from localhost (unknown [113.116.50.216])
        by smtp7 (Coremail) with SMTP id C8CowAAHNWLijlJi+8BiAg--.55584S2;
        Sun, 10 Apr 2022 16:01:39 +0800 (CST)
From:   Junwen Wu <wudaemon@163.com>
To:     jirislaby@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        wudaemon@163.com
Subject: Re: [PATCH v1] tty/sysrq: change the definition of sysrq_key_table's element to make it more readable
Date:   Sun, 10 Apr 2022 08:01:31 +0000
Message-Id: <20220410080131.124738-1-wudaemon@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <19e11d77-1f81-c5a8-8a72-4fb7616438bf@kernel.org>
References: <19e11d77-1f81-c5a8-8a72-4fb7616438bf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8CowAAHNWLijlJi+8BiAg--.55584S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruFy3XFyrXr4xCw4UGF13CFg_yoWfJFc_XF
        43WwnFkrW3uw43tFn7Ca1kZF9xWw4jvFy5JFy7CF4ft39YvrW7ArnFgFW7Zw45Xr4vvr12
        vw4DGasrWr1IvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRiiSHtUUUUU==
X-Originating-IP: [113.116.50.216]
X-CM-SenderInfo: 5zxgtvxprqqiywtou0bp/xtbBxxrebWB0GYnAnQAAs3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Jiri
     Sorry ,sysrq_showallcpus_op etc. are  not massive,but confused.  "CONFIG_TRACING" make the definition of the sysrq_ftrace_dump outside sysrq_key_table
but "CONFIG_SMP" make the definition of the sysrq_showallcpus_op inside sysrq_key_table. so unitify the code will make code more readable.
wujunwen is realy my name,Junwen Wu is better.

Jiri, I plan to modify the commit message as follow:
Subject: [PATCH v1] tty/sysrq: change the definition of sysrq_key_table's element to make it more readable

The definition of sysrq_key_table's elements, like sysrq_thaw_op and
sysrq_showallcpus_op are not consistent with sysrq_ftrace_dump_op, Consistency makes code more readable.

Signed-off-by: Junwen Wu <wudaemon@163.com>

Is this ok?

beside,if this commit message is ok,the subject will comment PATCH v2 ?

Thanks

