Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F804CC0E5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 16:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbiCCPOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 10:14:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbiCCPO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 10:14:27 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8559843ADB
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 07:13:39 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id q20so1009772wmq.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 07:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U6wWF6zo2yLTOKa9bK/sqze6lEH4FClncrhgNY9/b6Q=;
        b=bXZ3R6Z26ZsiWB7I7O4v8aRcUPpQinuuXwe0hFzNrT8gkjxwAuaDH6xTSzGQhALmd6
         SYr8FrKDf++OEaieiYv5Mde60Kxj1poSB2xzvdrDyIjWplUD1GfKHgqGlig1ZzjLMAOM
         934bm5gVLH5GcsKnKZDNiPRppFGb+pOkVuPjcrdKdntFrlGckvs9ZyTI9j1/3qPDgcet
         9K9JpiY3ZTPNXtL5j0gfnVn36HOHMLc0beBfvYFcebZQ9SpZQJv3+QVXeOcqVezHFVHE
         SX111QsFKlCkl4N4Ottc0GvArB2tGM0+Y4jcwCHPuCd7fAkFZcv3igFu+hjm/DIJq4T7
         122w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U6wWF6zo2yLTOKa9bK/sqze6lEH4FClncrhgNY9/b6Q=;
        b=0XP2rGC3RZ0Q9PHkHfSgVIm33AkYRRqMdZ9IsdJdBR2pi7gwApfZI7PBJZ/0Rm0XYo
         1jptIUQCeCkkY6Y2V9dnK+buPqKQd8idgC2uatAjljTzWmOnd4DlpRMrs3gpKXu6o6LO
         dUwKIvGtZr8un6Y3LwO8aWyHqsVOOqvaN7OHJkFjs8JD+QLBsfL3H1ENKRiHWZ89i1mU
         zX8d/9GG1RbPjvFdBH8+NtiUsCnCHhn/L0DnCdPjTLL22ApfGtYIlydIo5RPQoMKsFEp
         qCOHRyWiwHF09P6o2sOJEecQlDzG1JKCxJDMtj0fsYaJT5RPLcANiuVJFeCJgHow+i1S
         ISAw==
X-Gm-Message-State: AOAM532u4cd097IiRq76+xKKhBGgXl3kb/bbbdmUhC6t3u8OgbJYh9kl
        U6ELFzCPjEL8l80+jGtbhGuThnub7uIrEQ==
X-Google-Smtp-Source: ABdhPJxpgxLY4nCcAn3QpxYupF451BUImQUQK76VqCT9/y6X03/B+NDfxV2kGz28zWYCoijuwyqsTA==
X-Received: by 2002:a05:600c:4e8a:b0:383:52d8:a569 with SMTP id f10-20020a05600c4e8a00b0038352d8a569mr4131710wmq.74.1646320417501;
        Thu, 03 Mar 2022 07:13:37 -0800 (PST)
Received: from localhost.localdomain ([102.126.166.16])
        by smtp.gmail.com with ESMTPSA id r188-20020a1c2bc5000000b00387c81c32e7sm2597724wmr.8.2022.03.03.07.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 07:13:37 -0800 (PST)
From:   hatimmohammed369@gmail.com
To:     linux-kernel@vger.kernel.org
Cc:     Hatim Muhammed <hatimmohammed369@gmail.com>
Subject: [PATCH 2/2] Staging: Fixed coding style issues
Date:   Thu,  3 Mar 2022 17:13:33 +0200
Message-Id: <20220303151333.31144-1-hatimmohammed369@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hatim Muhammed <hatimmohammed369@gmail.com>

Signed-off-by: Hatim Muhammed <hatimmohammed369@gmail.com>

Removed unneccessary spaces
Use (unsigned int) instead of plain (int) conversions
Removed assignments inside if conditions
---
 usr/gen_init_cpio.c | 97 +++++++++++++++++++++++----------------------
 1 file changed, 50 insertions(+), 47 deletions(-)

diff --git a/usr/gen_init_cpio.c b/usr/gen_init_cpio.c
index 0e2c8a5838b1..b35ce15a7d47 100644
--- a/usr/gen_init_cpio.c
+++ b/usr/gen_init_cpio.c
@@ -39,7 +39,7 @@ static void push_string(const char *name)
 	offset += name_len;
 }
 
-static void push_pad (void)
+static void push_pad(void)
 {
 	while (offset & 3) {
 		putchar(0);
@@ -73,23 +73,22 @@ static void push_hdr(const char *s)
 static void cpio_trailer(void)
 {
 	char s[256];
-	const char name[] = "TRAILER!!!";
+	static const char name[] = "TRAILER!!!";
 
-	sprintf(s, "%s%08X%08X%08lX%08lX%08X%08lX"
-	       "%08X%08X%08X%08X%08X%08X%08X",
+	sprintf(s, "%s%08X%08X%08lX%08lX%08X%08lX%08X%08X%08X%08X%08X%08X%08X",
 		"070701",		/* magic */
 		0,			/* ino */
 		0,			/* mode */
-		(long) 0,		/* uid */
-		(long) 0,		/* gid */
+		0L,		/* uid */
+		0L,		/* gid */
 		1,			/* nlink */
-		(long) 0,		/* mtime */
+		0L,		/* mtime */
 		0,			/* filesize */
 		0,			/* major */
 		0,			/* minor */
 		0,			/* rmajor */
 		0,			/* rminor */
-		(unsigned)strlen(name)+1, /* namesize */
+		(unsigned int)strlen(name)+1, /* namesize */
 		0);			/* chksum */
 	push_hdr(s);
 	push_rest(name);
@@ -107,8 +106,7 @@ static int cpio_mkslink(const char *name, const char *target,
 
 	if (name[0] == '/')
 		name++;
-	sprintf(s,"%s%08X%08X%08lX%08lX%08X%08lX"
-	       "%08X%08X%08X%08X%08X%08X%08X",
+	sprintf(s, "%s%08X%08X%08lX%08lX%08X%08lX%08X%08X%08X%08X%08X%08X%08X",
 		"070701",		/* magic */
 		ino++,			/* ino */
 		S_IFLNK | mode,		/* mode */
@@ -116,12 +114,12 @@ static int cpio_mkslink(const char *name, const char *target,
 		(long) gid,		/* gid */
 		1,			/* nlink */
 		(long) default_mtime,	/* mtime */
-		(unsigned)strlen(target)+1, /* filesize */
+		(unsigned int)strlen(target)+1, /* filesize */
 		3,			/* major */
 		1,			/* minor */
 		0,			/* rmajor */
 		0,			/* rminor */
-		(unsigned)strlen(name) + 1,/* namesize */
+		(unsigned int)strlen(name) + 1,/* namesize */
 		0);			/* chksum */
 	push_hdr(s);
 	push_string(name);
@@ -140,7 +138,7 @@ static int cpio_mkslink_line(const char *line)
 	int gid;
 	int rc = -1;
 
-	if (5 != sscanf(line, "%" str(PATH_MAX) "s %" str(PATH_MAX) "s %o %d %d", name, target, &mode, &uid, &gid)) {
+	if (sscanf(line, "%" str(PATH_MAX) "s %" str(PATH_MAX) "s %o %d %d", name, target, &mode, &uid, &gid) != 5) {
 		fprintf(stderr, "Unrecognized dir format '%s'", line);
 		goto fail;
 	}
@@ -156,8 +154,7 @@ static int cpio_mkgeneric(const char *name, unsigned int mode,
 
 	if (name[0] == '/')
 		name++;
-	sprintf(s,"%s%08X%08X%08lX%08lX%08X%08lX"
-	       "%08X%08X%08X%08X%08X%08X%08X",
+	sprintf(s, "%s%08X%08X%08lX%08lX%08X%08lX%08X%08X%08X%08X%08X%08X%08X",
 		"070701",		/* magic */
 		ino++,			/* ino */
 		mode,			/* mode */
@@ -170,7 +167,7 @@ static int cpio_mkgeneric(const char *name, unsigned int mode,
 		1,			/* minor */
 		0,			/* rmajor */
 		0,			/* rminor */
-		(unsigned)strlen(name) + 1,/* namesize */
+		(unsigned int)strlen(name) + 1,/* namesize */
 		0);			/* chksum */
 	push_hdr(s);
 	push_rest(name);
@@ -211,7 +208,7 @@ static int cpio_mkgeneric_line(const char *line, enum generic_types gt)
 	int gid;
 	int rc = -1;
 
-	if (4 != sscanf(line, "%" str(PATH_MAX) "s %o %d %d", name, &mode, &uid, &gid)) {
+	if (sscanf(line, "%" str(PATH_MAX) "s %o %d %d", name, &mode, &uid, &gid) != 4) {
 		fprintf(stderr, "Unrecognized %s format '%s'",
 			line, generic_type_table[gt].type);
 		goto fail;
@@ -250,8 +247,7 @@ static int cpio_mknod(const char *name, unsigned int mode,
 
 	if (name[0] == '/')
 		name++;
-	sprintf(s,"%s%08X%08X%08lX%08lX%08X%08lX"
-	       "%08X%08X%08X%08X%08X%08X%08X",
+	sprintf(s, "%s%08X%08X%08lX%08lX%08X%08lX%08X%08X%08X%08X%08X%08X%08X",
 		"070701",		/* magic */
 		ino++,			/* ino */
 		mode,			/* mode */
@@ -264,7 +260,7 @@ static int cpio_mknod(const char *name, unsigned int mode,
 		1,			/* minor */
 		maj,			/* rmajor */
 		min,			/* rminor */
-		(unsigned)strlen(name) + 1,/* namesize */
+		(unsigned int)strlen(name) + 1,/* namesize */
 		0);			/* chksum */
 	push_hdr(s);
 	push_rest(name);
@@ -282,8 +278,8 @@ static int cpio_mknod_line(const char *line)
 	unsigned int min;
 	int rc = -1;
 
-	if (7 != sscanf(line, "%" str(PATH_MAX) "s %o %d %d %c %u %u",
-			 name, &mode, &uid, &gid, &dev_type, &maj, &min)) {
+	if (sscanf(line, "%" str(PATH_MAX) "s %o %d %d %c %u %u",
+			 name, &mode, &uid, &gid, &dev_type, &maj, &min) != 7) {
 		fprintf(stderr, "Unrecognized nod format '%s'", line);
 		goto fail;
 	}
@@ -308,9 +304,9 @@ static int cpio_mkfile(const char *name, const char *location,
 
 	mode |= S_IFREG;
 
-	file = open (location, O_RDONLY);
+	file = open(location, O_RDONLY);
 	if (file < 0) {
-		fprintf (stderr, "File %s could not be opened for reading\n", location);
+		fprintf(stderr, "File %s could not be opened for reading\n", location);
 		goto error;
 	}
 
@@ -328,26 +324,26 @@ static int cpio_mkfile(const char *name, const char *location,
 
 	filebuf = malloc(buf.st_size);
 	if (!filebuf) {
-		fprintf (stderr, "out of memory\n");
+		fprintf(stderr, "out of memory\n");
 		goto error;
 	}
 
-	retval = read (file, filebuf, buf.st_size);
+	retval = read(file, filebuf, buf.st_size);
 	if (retval < 0) {
-		fprintf (stderr, "Can not read %s file\n", location);
+		fprintf(stderr, "Can not read %s file\n", location);
 		goto error;
 	}
 
 	size = 0;
 	for (i = 1; i <= nlinks; i++) {
 		/* data goes on last link */
-		if (i == nlinks) size = buf.st_size;
+		if (i == nlinks)
+			size = buf.st_size;
 
 		if (name[0] == '/')
 			name++;
 		namesize = strlen(name) + 1;
-		sprintf(s,"%s%08X%08X%08lX%08lX%08X%08lX"
-		       "%08lX%08X%08X%08X%08X%08X%08X",
+		sprintf(s, "%s%08X%08X%08lX%08lX%08X%08lX%08lX%08X%08X%08X%08X%08X%08X",
 			"070701",		/* magic */
 			ino,			/* ino */
 			mode,			/* mode */
@@ -379,10 +375,12 @@ static int cpio_mkfile(const char *name, const char *location,
 	}
 	ino++;
 	rc = 0;
-	
+
 error:
-	if (filebuf) free(filebuf);
-	if (file >= 0) close(file);
+	if (filebuf)
+		free(filebuf);
+	if (file >= 0)
+		close(file);
 	return rc;
 }
 
@@ -395,7 +393,7 @@ static char *cpio_replace_env(char *new_location)
 	       (end = strchr(start + 2, '}'))) {
 		*start = *end = 0;
 		var = getenv(start + 2);
-		snprintf(expanded, sizeof expanded, "%s%s%s",
+		snprintf(expanded, sizeof(expanded), "%s%s%s",
 			 new_location, var ? var : "", end + 1);
 		strcpy(new_location, expanded);
 	}
@@ -415,9 +413,9 @@ static int cpio_mkfile_line(const char *line)
 	int end = 0, dname_len = 0;
 	int rc = -1;
 
-	if (5 > sscanf(line, "%" str(PATH_MAX) "s %" str(PATH_MAX)
+	if (sscanf(line, "%" str(PATH_MAX) "s %" str(PATH_MAX)
 				"s %o %d %d %n",
-				name, location, &mode, &uid, &gid, &end)) {
+				name, location, &mode, &uid, &gid, &end) < 5) {
 		fprintf(stderr, "Unrecognized file format '%s'", line);
 		goto fail;
 	}
@@ -427,7 +425,7 @@ static int cpio_mkfile_line(const char *line)
 
 		dname = malloc(strlen(line));
 		if (!dname) {
-			fprintf (stderr, "out of memory (%d)\n", dname_len);
+			fprintf(stderr, "out of memory (%d)\n", dname_len);
 			goto fail;
 		}
 
@@ -449,9 +447,10 @@ static int cpio_mkfile_line(const char *line)
 		dname = name;
 	}
 	rc = cpio_mkfile(dname, cpio_replace_env(location),
-	                 mode, uid, gid, nlinks);
+			mode, uid, gid, nlinks);
  fail:
-	if (dname_len) free(dname);
+	if (dname_len)
+		free(dname);
 	return rc;
 }
 
@@ -524,7 +523,7 @@ static const struct file_handler file_handler_table[] = {
 
 #define LINE_SIZE (2 * PATH_MAX + 50)
 
-int main (int argc, char *argv[])
+int main(int argc, char *argv[])
 {
 	FILE *cpio_list;
 	char line[LINE_SIZE];
@@ -572,9 +571,10 @@ int main (int argc, char *argv[])
 		exit(1);
 	}
 	filename = argv[optind];
+	cpio_list = fopen(filename, "r");
 	if (!strcmp(filename, "-"))
 		cpio_list = stdin;
-	else if (!(cpio_list = fopen(filename, "r"))) {
+	else if (!cpio_list) {
 		fprintf(stderr, "ERROR: unable to open '%s': %s\n\n",
 			filename, strerror(errno));
 		usage(argv[0]);
@@ -591,8 +591,8 @@ int main (int argc, char *argv[])
 			/* comment - skip to next line */
 			continue;
 		}
-
-		if (! (type = strtok(line, " \t"))) {
+		type = strtok(line, " \t");
+		if (!type) {
 			fprintf(stderr,
 				"ERROR: incorrect format, could not locate file type line %d: '%s'\n",
 				line_nr, line);
@@ -610,7 +610,8 @@ int main (int argc, char *argv[])
 			continue;
 		}
 
-		if (! (args = strtok(NULL, "\n"))) {
+		args = strtok(NULL, "\n");
+		if (!args) {
 			fprintf(stderr,
 				"ERROR: incorrect format, newline required line %d: '%s'\n",
 				line_nr, line);
@@ -619,8 +620,10 @@ int main (int argc, char *argv[])
 
 		for (type_idx = 0; file_handler_table[type_idx].type; type_idx++) {
 			int rc;
-			if (! strcmp(line, file_handler_table[type_idx].type)) {
-				if ((rc = file_handler_table[type_idx].handler(args))) {
+
+			if (!strcmp(line, file_handler_table[type_idx].type)) {
+				rc = file_handler_table[type_idx].handler(args);
+				if (rc) {
 					ec = rc;
 					fprintf(stderr, " line %d\n", line_nr);
 				}
@@ -628,7 +631,7 @@ int main (int argc, char *argv[])
 			}
 		}
 
-		if (NULL == file_handler_table[type_idx].type) {
+		if (file_handler_table[type_idx].type == NULL) {
 			fprintf(stderr, "unknown file type line %d: '%s'\n",
 				line_nr, line);
 		}
-- 
2.35.1

