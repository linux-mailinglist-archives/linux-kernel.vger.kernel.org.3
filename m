Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9766055C922
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237857AbiF0PTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 11:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236947AbiF0PTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 11:19:16 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C07265D;
        Mon, 27 Jun 2022 08:19:15 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id e40so13567239eda.2;
        Mon, 27 Jun 2022 08:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j3PIhPbhaqEhLj66dfXeb9jA8JLy3ZCixC1TiZD/V1U=;
        b=GXYpB0dQaHyLpHtFcnvI9okMUwzWyHlYrYGR61LQIkYAs8A2chFb3B4G38pKTz7SaA
         +uOZvaAN7leINAmEsMOHM7bz2AfCPwD47LVa+oU9LWqKz0BoKlc0kL+I6uyhyITR0FS4
         1GJxFRldA9haf2oly4ufogPJWt1dUMRI+Hqr+J7sMPCrqj+x5pi/uezLNF1+RbOdVNFS
         kXZNymVWEaqD/mGrMdmnQvlNf4INJiN/BXSd/2/FbnYwrYJpjJRVLbdL4Zd/WMuOyUm+
         RnjorsxJ3PPw9i5GTFs8pnnue9MBrwvpzZVC/SD8h6ZHPM0mkysHDjy4PpGhpOJhEdD2
         ARug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j3PIhPbhaqEhLj66dfXeb9jA8JLy3ZCixC1TiZD/V1U=;
        b=wYwGCM/DfRqUdy9eByDF4Uu3bKaIO6B2/MDRW+3DW+UkihNdJZcxGpNoa7MRU/E8uy
         qbeOSshE+FIaomZvSmCdBRIQMAvksBhKhuyCcIOjebeoNQVZIYIVB2y1T9fqSfieZgQY
         L3zuEoSOChKcLn+Q/bNZ/7Ncqz+AVWWZqqkCopN1G5z5r5SNLVYzBDEug4lGZKgfGr5L
         JlYZqmGGKQPAWopefxJpZirpg8VUEOlSt4dHfeXPvN1wjK4+D9IQDtmS2+2u3y30VZnb
         XWt4c1+GuEUsWjiiha7c+/pQzSgm31KpabDe0gCOBMR14yWWeZAahEQuwH954SJbnoWQ
         brPQ==
X-Gm-Message-State: AJIora+b6hGs3noz4OFn3wssZneiDp3eHguFGCQX5wY2cusIx/Tb5ysJ
        5HC9snTj0Nc7jn2BcTluU/4=
X-Google-Smtp-Source: AGRyM1sqcGM1BIhUBAPDD7tQc5itwMQaZG2B9GVbdgylYetBgqrnsZgdO4QWrAEXOB/JyKLsaKe9mQ==
X-Received: by 2002:a05:6402:2684:b0:435:dcaf:29b3 with SMTP id w4-20020a056402268400b00435dcaf29b3mr17543415edd.358.1656343153365;
        Mon, 27 Jun 2022 08:19:13 -0700 (PDT)
Received: from felia.fritz.box (200116b826511b0021a0c74157938809.dip.versatel-1u1.de. [2001:16b8:2651:1b00:21a0:c741:5793:8809])
        by smtp.gmail.com with ESMTPSA id z8-20020a170906434800b00722f2a0944fsm5076901ejm.107.2022.06.27.08.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 08:19:12 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>, linux-doc@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [RFC PATCH 00/11] docs: remove submitting-drivers.rst
Date:   Mon, 27 Jun 2022 17:18:08 +0200
Message-Id: <20220627151819.22694-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Jonathan, dear Federico, dear Alex, dear Yanteng, dear Hu,


Here is an attempt to delete submitting-drivers with some improvements
and clean-up in other documentation places to convince ourselves that
nothing valuable is lost when deleting this checklist.

Patch 1, 2 and 3 is just basic clean-up before adding a new reference (see
Patch 4). Patch 4 adds the one reference from submitting-drivers, not
already mentioned elsewhere in the repository. Patch 5 updates a confusing
statement in devices.rst from earlier .txt/.tex distinction times to the
new state now with Sphinx & .rst.

Patch 6 finally deletes the outdated document, with a cross-check what is
covered elsewhere and few open questions (see below).

Patch 7 to 11 are weak attempts to adjust the translation, but they need
to be taken further by others due to my lack of knowledge on the other
languages. They would currently also cause new warnings in the doc-build
right now.

I hope that patches 1 to 6 can be picked into doc-next, and then we see
how to fix up the translations as well.


Further open considerations:

  - Should we add some subsection/paragraph on Testing to "A guide on
    kernel development process", which then further refers to
    power/drivers-testing.rst for testing the power management of the
    driver?

    (I am bit surprised that code-checking tools are mentioned, but not
    much more on actual kernel testing is mentioned there.)

  - Should we be a bit more explicit on how and when to add a MAINTAINERS
    entry, besides the short note in 6.Followthrough.rst?

  - Translations of submitting-patches.rst and 8.Conclusion.rst in Asian
    languages include a reference to submitting-drivers, I cannot adjust
    the text due to my lack of understanding of the surrounding text.

    ja_JP/SubmittingPatches:ているなら、Documentation/process/submitting-drivers.rst にも目を通してください。
    zh_CN/process/8.Conclusion.rst:和 :ref:`Documentation/translations/zh_CN/process/submitting-drivers.rst <cn_submittingdrivers>`
    zh_CN/process/submitting-patches.rst::ref:`Documentation/process/submitting-drivers.rst <submittingdrivers>`
    zh_TW/process/8.Conclusion.rst:和 :ref:`Documentation/translations/zh_TW/process/submitting-drivers.rst <tw_submittingdrivers>`
    zh_TW/process/submitting-patches.rst::ref:`Documentation/process/submitting-drivers.rst <submittingdrivers>`

    This currently lead to some new warnings in this patch series. I hope
    some native speakers of those languages can help out here. The other
    references were adjusted on a best guess of the text, which should be
    confirmed by native-speaking reviewers.

Other topics I encountered:

  - in translations/it_IT/process/submitting-patches.rst, the guideline
    link for patches to device tree binding seems wrong (although I do not
    speak Italian, so it is also just a guess).


Generally, I hope we are now all well-convinced to delete submitting-drivers.

Anything else needed to be convinced? I put already some thought into it,
and I am willing to add more content in other documents to properly get rid
of this outdated one here, or just starting writing a good new checklist
for driver submission that reflect what the majority of maintainers want
to see submitters do.


As future work---with this one submitting checklist gone---I see the harder
follow-up task to synchronize and clean up the various submission hints/
guidelines/checklists in the remaining kernel documentation that partly
overlap and differ in detail, their structure (unstructured, unordered
lists vs. sections and subsections) and their state of being outdated:

  Documentation/process/submit-checklist.rst
  Documentation/process/submitting-patches.rst
  MAINTAINERS#Tips for patch submitters

My next task at hand is to read through all three documents, figure out
what still applies and what is outdated, determine a good common structure
for all three documents, include cross-links and make them to some extent
follow a clear consistent policy. E.g., one document is a more detailed
description of everything mentioned in the short list of another document.
I will try to work through that in the next months or motivate and guide
some colleague or mentee to work together with me on that.


Best regards,

Lukas


Lukas Bulwahn (11):
  docs: kernel-docs: order reference from newest to oldest
  docs: kernel-docs: shorten the lengthy doc title
  docs: kernel-docs: reflect that it is community-maintained
  docs: kernel-docs: add a reference mentioned in submitting-drivers.rst
  docs: admin: devices:  drop confusing outdated statement on Latex
  docs: process: remove outdated submitting-drivers.rst
  docs: it_IT: align to submitting-drivers removal
  docs: ja_JP: howto: remove reference to removed submitting-drivers
  docs: ko_KR: howto: remove reference to removed submitting-drivers
  docs: zh_CN: align to submitting-drivers removal
  docs: zh_TW: align to submitting-drivers removal

 Documentation/admin-guide/devices.rst         |   7 +-
 Documentation/hwmon/submitting-patches.rst    |   1 -
 Documentation/kernel-hacking/hacking.rst      |   3 +-
 Documentation/process/5.Posting.rst           |   3 +-
 Documentation/process/8.Conclusion.rst        |  16 +-
 Documentation/process/howto.rst               |   4 +-
 Documentation/process/index.rst               |   1 -
 Documentation/process/kernel-docs.rst         |  62 +++---
 Documentation/process/submitting-drivers.rst  | 194 ------------------
 Documentation/process/submitting-patches.rst  |   5 +-
 .../it_IT/kernel-hacking/hacking.rst          |   3 +-
 .../translations/it_IT/process/5.Posting.rst  |   5 +-
 .../it_IT/process/8.Conclusion.rst            |   3 +-
 .../translations/it_IT/process/howto.rst      |   3 +-
 .../translations/it_IT/process/index.rst      |   1 -
 .../it_IT/process/submitting-drivers.rst      |  16 --
 .../it_IT/process/submitting-patches.rst      |   6 +-
 Documentation/translations/ja_JP/howto.rst    |   2 +-
 Documentation/translations/ko_KR/howto.rst    |   2 +-
 .../zh_CN/kernel-hacking/hacking.rst          |   3 +-
 .../translations/zh_CN/process/5.Posting.rst  |   3 +-
 .../translations/zh_CN/process/howto.rst      |   1 -
 .../translations/zh_CN/process/index.rst      |   1 -
 .../zh_CN/process/submitting-drivers.rst      | 160 ---------------
 .../translations/zh_TW/process/5.Posting.rst  |   3 +-
 .../translations/zh_TW/process/howto.rst      |   1 -
 .../translations/zh_TW/process/index.rst      |   1 -
 .../zh_TW/process/submitting-drivers.rst      | 164 ---------------
 28 files changed, 64 insertions(+), 610 deletions(-)
 delete mode 100644 Documentation/process/submitting-drivers.rst
 delete mode 100644 Documentation/translations/it_IT/process/submitting-drivers.rst
 delete mode 100644 Documentation/translations/zh_CN/process/submitting-drivers.rst
 delete mode 100644 Documentation/translations/zh_TW/process/submitting-drivers.rst

-- 
2.17.1

