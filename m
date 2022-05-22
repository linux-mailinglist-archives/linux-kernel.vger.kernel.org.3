Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE82F5305C7
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 22:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351102AbiEVUOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 16:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241222AbiEVUO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 16:14:28 -0400
X-Greylist: delayed 1525 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 22 May 2022 13:14:28 PDT
Received: from out5.nocdirect.com (out5.nocdirect.com [69.73.171.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B48C369DA
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 13:14:27 -0700 (PDT)
Received: from binky.nswebhost.com ([69.73.168.248])
        by spamexperts03.nocdirect.com with esmtpsa (TLSv1.2:AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <support@iesottawa.ca>)
        id 1nsrZS-0000Rr-1N
        for linux-kernel@vger.kernel.org; Sun, 22 May 2022 15:48:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iesottawa.ca; s=default; h=Sender:Content-Type:MIME-Version:Message-ID:
        Reply-To:From:Date:Subject:To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tsytaq9P6jbx84sZaeZ2ujyYY054YqWU2QI73VCcE8s=; b=zy3AB4uzyneHulkftVgzocu6pd
        MABaKWRbIcAdqN6k3etK3RVRwIFTva5FI6ue07oFU5KGDQn/Y0Y6V1mOEMu7IhoSzxeTO7GkZt2bg
        zbn8JXS0/tulF5H3D59xWuTnDk1JsD/z0nUhFOQEsAxLP6xFceI9w9IWWuD2CFxMik8xgqZQl/7AE
        Oqb1jzN/4z0f5FhASlklszUleqPEfImb1CvO5ihmIsF+zIU11lmgxOk+iYNUy4laeb5okUj+URMUh
        euQMo/2cCgH0Nacjbs/BY847gWCnncF5vPdHV7CPV47j3R7jDWQutew6ud5oT1nyWwkCW7cUjBcEC
        IbA3qL/A==;
Received: from ottawa by binky.nswebhost.com with local (Exim 4.93)
        (envelope-from <support@iesottawa.ca>)
        id 1nsrYQ-00078F-Nq
        for linux-kernel@vger.kernel.org; Sun, 22 May 2022 15:47:54 -0400
To:     linux-kernel@vger.kernel.org
Subject: Re: Looking forward to hearing from you
X-PHP-Script: iesottawa.ca/modules/mod_simplefileuploadv1.3/elements/bcqkhulk.php for 36.37.185.70
Date:   Sun, 22 May 2022 19:47:54 +0000
From:   "Mrs. Mamand Mashamsul" <support@iesottawa.ca>
Reply-To: mrsmamands@gmail.com
Message-ID: <c8007d75efc87d5c08acf625fb52bec4@iesottawa.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender:  <ottawa@binky.nswebhost.com>
X-Originating-IP: 69.73.168.248
X-SpamExperts-Domain: nocdirect.com
X-SpamExperts-Username: binky
Authentication-Results: nocdirect.com; auth=pass (login) smtp.auth=binky@nocdirect.com
X-SpamExperts-Outgoing-Class: unsure
X-SpamExperts-Outgoing-Evidence: Combined (0.83)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT9NxnHXhFI9aLFhf4G9YVDvPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5z4WkZ/TJaiaBbP2NJqrVHtfCzdNGNoLjYW00m5NbCHvI9w
 knWGobBIYos3d1n2bREdEtB1ZMYATUElPOm9F2QL5WCy5VkstzhnxgTXqsdmp/Wn05gqPZge6fRu
 MJPh6sDu/e86mZjV6Sy6Asexqznjdhvi3DEM5gl7QMCSadIaw/xBB7G59hKJv5m89DUmcUOKgBRI
 fcZUfZwN89VAi8ym19ilIzt3BUAOXsUYvJDWUnTaeQtlKubP6iUTjj6yPASOmrbMWhZFkvyjvYIF
 be8tdb9BwqvSI91oKEKHszPrHGBuMmAYf4hbVE3z3Ot33ZD69jSlw+osi/uaVnmuT0ZJdzvP3W79
 /xjWif9pd+MBAjpgtEJiC/RNPkrUEgky+JPZ4xpigOktCp6Xcz12tfjFPd0rEuGjFyZoidhtHm+W
 of0KyhOJV75thdWrPXwaDw7qAlzlYouTdrqAP9b5VrNZltK+MtP+Q+MOaQQT+Vn8BIlSPGIn6LIh
 6vfZt6Tuc+uVfVL7ygxIxIEhQBgsu7ia6J1fhOzjF0b4LXcjJZ5los0t+yXgVv1fVKFGpgDKkeVe
 5S10FHDQLMw7J6FDq9AYEe5lbnSaWYwizmSCrJReSFse4eZ470w+Lz+8dxPiymjRtFuayQSHKxuV
 s+RmqoRq3CRiRJK4GhOXBQPqhauyDxzi9cft92qJ+i0lqzcyoqFVlQ1vUe1/iWWVtQAedSdo9av6
 EFOzO12YHcsnIh1JW4zbg0PPWMPuZRPoz/Oktjchu1/rdU1t/SWu+yxj6TsAEdwhoW9jAAyH9d93
 /xvErl0K1XacwNVrdseLPwMNJOx8ZEDeLRyWnNuP8Qfo5808h6acV+m/1HtJVsJEtDsfABYzpPqG
 BvR0ks1/IouSjksSHgDvqOblwwr6dI9qLjQ+Yt1DGpoalxmasWifUN8mz4PFqAsJjBDQgYPkM7DW
 +lBUfKHrqn8cv69cP2IsSSTyMS+4ayUpOtEhdxekWDmK9g==
X-Report-Abuse-To: spam@spamexperts01.nocdirect.com
X-Spam-Status: Yes, score=6.8 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        HK_NAME_MR_MRS,PHP_SCRIPT,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.7 RCVD_IN_DNSWL_LOW RBL: Sender listed at https://www.dnswl.org/,
        *       low trust
        *      [69.73.171.4 listed in list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.6719]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.7 SPF_SOFTFAIL SPF: sender does not match SPF record (softfail)
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.5 PHP_SCRIPT Sent by PHP script
        *  1.0 HK_NAME_MR_MRS No description available.
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greatings Dear

I am Mrs. Mamand Mashamsul, from Kabul, Capital of Afghanistan. With due respect, I want to know if foreigners can buy and own properties in your beautiful country, I desire to relocate my investment capital abroad where it will generate more returns. 
 
I will appreciate your response. Please let me know your ideas and knowledge regarding my research. In Any viable investment idea you suggest to me will be also be considered. 
 
Looking forward to hearing from you.

Best regards,
Mrs. Mamand Mashamsul

